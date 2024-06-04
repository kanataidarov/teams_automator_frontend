import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/data/dynamic.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/files.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/record_button.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Database _db;
  late final AudioRecorder recorder;

  bool isRecording = false;
  bool recorderReady = false;

  @override
  void initState() {
    ClientService().init();

    recorder = AudioRecorder();
    openTheRecorder().then((val) {
      setState(() {
        recorderReady = val;
      });
    });
    _logger.d('Recorder initialized');

    Files.instance.init();
    DbHelper.instance.database.then((db) {
      setState(() {
        _db = db;
      });
    });

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
      // await startRecording();
    } else {
      // await stopRecording();
      setState(() {
        isRecording = false;
      });
    }
  }

  void handleClient(BuildContext ctx) async {
    QaProvider.instance.initQa().then((val) async {
      _db.query(Qa.tableName).then((val) {
        _logger.d('rows selected - ${val.length}');
      });
    });

    return;

    ClientService.instance
        .transcribe(Files.instance.getRecodingPath())
        .then((transcription) {
      ctx.read<TempData>().setTranscription(transcription);
      ClientService.instance.chatBot(ctx).then((answers) {
        _logger.d('ChatBot response - $answers');
        ctx.read<TempData>().setAnswers(answers);
      });
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interview Automator')),
      drawer: const DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RecordButton(isRecording: isRecording, recordFunc: record),
            ElevatedButton(
                onPressed: () {
                  handleClient(ctx);
                },
                child: const Text('CHAT_BOT')),
          ],
        ),
      ),
    );
  }
}
