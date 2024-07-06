import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/screen/settings.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/files.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/record_button.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:record/record.dart';

Logger _logger = Logger(level: Level.debug);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AudioRecorder recorder;

  bool isRecording = false;
  bool recorderReady = false;

  @override
  void initState() {
    super.initState();

    if (!recorderReady) {
      recorder = AudioRecorder();
      _openTheRecorder().then((val) {
        setState(() {
          recorderReady = val;
        });
      });
      _logger.d('Recorder (re)initialized');
    }
  }

  @override
  void dispose() {
    recorder.dispose();
    DbHelper.instance.close();
    super.dispose();
  }

  Future<bool> _openTheRecorder() async {
    var hasPerm = await recorder.hasPermission();

    if (!hasPerm) {
      _logger.w('Microphone permission not granted');
    }

    return hasPerm;
  }

  Future<void> _startRecording() async {
    if (!recorderReady) return;

    String filePath = await _getRecordingPath();

    try {
      await recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
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
    if (!recorderReady) return;

    try {
      recorder.stop().then((path) {
        _logger.i('Stopped recording - $path');
        SettingsProvider.instance.byName('debug_enabled').then((stng) {
          if (!bool.parse(stng.value!)) handleClient(context);
        });
      });
    } catch (e) {
      _logger.e('Error stopping recording - ${e.toString()}', error: e);
    }
  }

  void record(BuildContext context) async {
    if (!recorderReady) return;

    if (!isRecording) {
      setState(() {
        isRecording = true;
      });
      await _startRecording();
    } else {
      await _stopRecording(context);
      setState(() {
        isRecording = false;
      });
    }
  }

  void handleClient(BuildContext context) async {
    // TODO solve callback hell
    _getRecordingPath().then((path) {
      ClientService.instance.transcribe(path).then((transcription) {
        SettingsProvider.instance.byName('transcription').then((stng) async {
          stng.value = transcription;
          await SettingsProvider.instance.update(stng);
        });

        ClientService.instance.chatBot(context).then((answers) async {
          for (var answer in answers) {
            var qas = (await DbHelper.instance.database)
                .query(Qa.tableName, where: 'id = ?', whereArgs: [answer.qid]);
            var qa = Qa.fromMap((await qas).first);
            qa.answer = answer.content;
            await QaProvider.instance.update(qa);
          }
        });
      });
    });
  }

  _debugButton(BuildContext context) => FutureBuilder<bool>(
      future: isDebugEnabled(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        Widget cnt = Container();
        if (snapshot.hasData) {
          bool isDebug = snapshot.data!;
          if (isDebug) {
            cnt = FloatingActionButton(
                onPressed: () => handleClient(context),
                tooltip: 'Debug',
                child: const Icon(Icons.telegram_outlined));
          }
        }
        return cnt;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Interview Automator')),
        drawer: const DrawerWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RecordButton(isRecording: isRecording, recordFunc: record)
            ],
          ),
        ),
        floatingActionButton: _debugButton(context));
  }
}
