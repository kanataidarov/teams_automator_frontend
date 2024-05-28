import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRecording = false;

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
                  setState(() {
                    isRecording = true;
                  });
                },
                onLongPressUp: () async {
                  setState(() {
                    isRecording = false;
                  });
                },
                child: isRecording
                    ? const Icon(Icons.radio_button_on,
                        color: Colors.red, size: 230)
                    : const Icon(Icons.panorama_fish_eye,
                        color: Colors.black, size: 230),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
