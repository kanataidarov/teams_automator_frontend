import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 99,
      height: 99,
      child: CircularProgressIndicator(),
    );
  }
}
