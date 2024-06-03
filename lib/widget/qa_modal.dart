import 'package:flutter/material.dart';

class QaModal extends StatefulWidget {
  final Function getSetting;
  final int idx;

  const QaModal({super.key, required this.getSetting, required this.idx});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<QaModal> {
  late TextEditingController tfControl;

  @override
  void initState() {
    tfControl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tfControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    tfControl.text = widget.getSetting(widget.idx);

    return AlertDialog(
      title: Text('Question ${widget.idx}'),
      content: TextField(
          controller: tfControl,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          expands: true),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Navigator.pop(ctx, tfControl.text);
            },
            child: const Text('OK'))
      ],
    );
  }
}