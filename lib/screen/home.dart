import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/screen/settings.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/files.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
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
    recorder = AudioRecorder();
    openTheRecorder().then((val) {
      setState(() {
        recorderReady = val;
      });
    });
    _logger.d('Recorder initialized');

    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    DbHelper.instance.close();
    super.dispose();
  }

  Future<bool> openTheRecorder() async {
    var hasPerm = await recorder.hasPermission();

    if (!hasPerm) {
      _logger.w('Microphone permission not granted');
    }

    return hasPerm;
  }

  Future<void> startRecording() async {
    if (!recorderReady) return;

    String filePath = Files.instance.getRecodingPath();

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

  Future<void> stopRecording() async {
    if (!recorderReady) return;

    try {
      await recorder.stop().then((val) {
        _logger.i('Stopped recording - $val');
      });
    } catch (e) {
      _logger.e('Error stopping recording - ${e.toString()}', error: e);
    }
  }

  void record() async {
    if (!recorderReady) return;

    if (!isRecording) {
      setState(() {
        isRecording = true;
      });
      await startRecording();
    } else {
      await stopRecording();
      setState(() {
        isRecording = false;
      });
    }
  }

  void handleClient(BuildContext ctx) async {
    ClientService.instance
        .transcribe(Files.instance.getRecodingPath())
        .then((transcription) {
      SettingsProvider.instance.byName('transcription').then((stng) async {
        stng.value = transcription;
        await SettingsProvider.instance.update(stng);
      });

      ClientService.instance.chatBot(ctx).then((answers) async {
        for (var answer in answers) {
          var qas = (await DbHelper.instance.database)
              .query(Qa.tableName, where: 'id = ?', whereArgs: [answer.qid]);
          var qa = Qa.fromMap((await qas).first);
          qa.answer = answer.content;
          await QaProvider.instance.update(qa);
        }
      });
    });
  }

  normal(BuildContext ctx, bool isDebug) => !isDebug
      ? Container()
      : FloatingActionButton(
          onPressed: () => handleClient(ctx),
          tooltip: 'Debug',
          child: const Icon(Icons.telegram_outlined));

  @override
  Widget build(BuildContext ctx) {
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
        floatingActionButton: FutureBuilder<bool>(
            future: isDebugEnabled(),
            builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) {
              Widget cont = Container();
              if (snapshot.hasData) {
                cont = normal(ctx, snapshot.data!);
              }
              return cont;
            }));
  }
}
