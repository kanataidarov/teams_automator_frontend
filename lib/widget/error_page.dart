import 'package:flutter/material.dart';
import '../storage/model/parent.dart';

class ErrorPage extends StatelessWidget {
  final AsyncSnapshot<List<DbModel>> snapshot;

  const ErrorPage({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      )
    ]);
  }
}
