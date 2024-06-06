import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  final bool isRecording;
  final Function recordFunc;

  const RecordButton(
      {super.key, required this.isRecording, required this.recordFunc});

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: isRecording,
      glowColor: Colors.red,
      glowRadiusFactor: 0.1,
      startDelay: const Duration(milliseconds: 1),
      child: GestureDetector(
        onLongPress: () async {
          recordFunc(context);
        },
        onLongPressUp: () async {
          recordFunc(context);
        },
        child: isRecording
            ? const Icon(Icons.radio_button_on, color: Colors.red, size: 230)
            : const Icon(Icons.panorama_fish_eye,
                color: Colors.black, size: 230),
      ),
    );
  }
}
