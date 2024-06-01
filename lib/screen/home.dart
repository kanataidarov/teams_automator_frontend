import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/storage/storage.dart';
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
    ClientService().init();

    recorder = AudioRecorder();
    openTheRecorder().then((val) {
      setState(() {
        recorderReady = val;
      });
    });

    Storage().init();

    super.initState();
    _logger.d('Recorder initialized');
  }

  @override
  void dispose() {
    recorder.dispose();
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

    String filePath = Storage.instance.getRecodingPath();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AvatarGlow(
              animate: isRecording,
              glowColor: Colors.red,
              glowRadiusFactor: 0.1,
              startDelay: const Duration(milliseconds: 1),
              child: GestureDetector(
                onLongPress: () async {
                  record();
                },
                onLongPressUp: () async {
                  record();
                },
                child: isRecording
                    ? const Icon(Icons.radio_button_on,
                        color: Colors.red, size: 230)
                    : const Icon(Icons.panorama_fish_eye,
                        color: Colors.black, size: 230),
              ),
            ),
            ElevatedButton(
                onPressed: () => ClientService.instance.recognize(
                    Storage.instance.getRecodingPath()
                ),
                child: const Text('SEND REMOTE'))
          ],
        ),
      ),
    );
  }
}
