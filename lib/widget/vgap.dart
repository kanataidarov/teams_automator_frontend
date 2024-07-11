import 'package:flutter/material.dart';

class VGap extends StatelessWidget {
  final double height;

  const VGap({super.key, this.height = 9});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
