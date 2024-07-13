import '../grpc/interview_automator/openai_api.pbenum.dart';
import '../storage/memory.dart';
import '../widget/vgap.dart';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/screen/settings.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/files.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/debug_button.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/record_button.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:provider/provider.dart';
import 'package:record/record.dart';

Logger _logger = Logger(level: Level.debug);

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AudioRecorder _recorder;
  late Stage _selectedStage;

  bool _isRecording = false;
  bool _recorderReady = false;
  final Map<QIntent, bool> _subStages = {
    QIntent.CLARIFY: false,
    QIntent.SOLVE: true,
    QIntent.CORRECT: false
  };

  @override
  void initState() {
    super.initState();

    _selectedStage = context.read<Memory>().lastStage;

    if (!_recorderReady) {
      _recorder = AudioRecorder();
      _openTheRecorder().then((val) {
        setState(() {
          _recorderReady = val;
        });
      });
      _logger.d('Recorder (re)initialized');
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    DbHelper.instance.close();
    super.dispose();
  }

  Future<bool> _openTheRecorder() async {
    var hasPerm = await _recorder.hasPermission();

    if (!hasPerm) {
      _logger.w('Microphone permission not granted');
    }

    return hasPerm;
  }

  Future<void> _startRecording() async {
    if (!_recorderReady) return;

    String filePath = await _getRecordingPath();

    try {
      await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
            bitRate: 16000,
            sampleRate: 11025,
            numChannels: 1
          ),
          path: filePath);
      _logger.i('Started recording - $filePath');
    } catch (e) {
      _logger.e('Error starting recording - ${e.toString()}', error: e);
    }
  }

  Future<String> _getRecordingPath() async {
    String filePath = Files.instance.getDefaultRecodingPath();
    final val = (await SettingsProvider.instance.byName('voice_file_path'))
        .value!
        .split(';');
    final defaultVoicePath = bool.parse(val[0]);
    if (!defaultVoicePath) {
      filePath = val[1];
    }
    return filePath;
  }

  Future<void> _stopRecording(BuildContext context) async {
    if (!_recorderReady) return;

    try {
      _recorder.stop().then((path) {
        _logger.i('Stopped recording - $path');
        SettingsProvider.instance.byName('debug_enabled').then((stng) {
          if (!bool.parse(stng.value!)) handleClient(context);
        });
      });
    } catch (e) {
      _logger.e('Error stopping recording - ${e.toString()}', error: e);
    }
  }

  void _record(BuildContext context) async {
    if (!_recorderReady) return;

    if (!_isRecording) {
      setState(() {
        _isRecording = true;
      });
      await _startRecording();
    } else {
      await _stopRecording(context);
      setState(() {
        _isRecording = false;
      });
    }
  }

  void handleClient(BuildContext ctx) async {
    _getRecordingPath().then((path) {
      ClientService.instance.transcribe(path).then((transcription) {
        SettingsProvider.instance.byName('transcription').then((stng) async {
          stng.value = transcription;
          await SettingsProvider.instance.update(stng);
        });

        final selectedIntent =
            _subStages.keys.firstWhere((k) => _subStages[k]!);

        _logger.d(
            'Calling ClientService.handleChatBot with parameters: ${_selectedStage.name}, ${selectedIntent.name}');
        ClientService.instance
            .handleChatBot(ctx, _selectedStage, selectedIntent);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        drawer: const DrawerWidget(),
        body: Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            labelText: 'Stage', border: OutlineInputBorder()),
                        items: Stage.values
                            .where((e) => e.value != 0)
                            .map((Stage item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Row(children: [
                                const Icon(Icons.question_answer_outlined),
                                const VGap(),
                                Text(toBeginningOfSentenceCase(
                                    item.name.toLowerCase()))
                              ]));
                        }).toList(),
                        onChanged: (Stage? selectedItem) {
                          context.read<Memory>().setStage(selectedItem!);
                          setState(() {
                            _selectedStage = selectedItem;
                          });
                        },
                        value: _selectedStage),
                    const VGap(height: 27),
                    LayoutBuilder(builder: (context, limits) {
                      return ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int selectedIndex) {
                          QIntent intent =
                              _subStages.keys.toList()[selectedIndex];
                          setState(() {
                            _subStages.updateAll(
                                (k, v) => intent == k ? true : false);
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        constraints: BoxConstraints(
                          minHeight: 50,
                          minWidth: limits.maxWidth / 3.1,
                        ),
                        isSelected: List.of(_subStages.values),
                        children: _subStages.keys
                            .map((QIntent key) => Text(
                                toBeginningOfSentenceCase(
                                    key.name.toLowerCase())))
                            .toList(),
                      );
                    }),
                    const VGap(),
                    Expanded(
                        child: RecordButton(
                            isRecording: _isRecording, record: _record))
                  ]),
            )),
        floatingActionButton: DebugButton(context,
            isDebugEnabled: isDebugEnabled, handle: handleClient));
  }
}
