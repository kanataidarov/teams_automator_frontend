import 'package:flutter/material.dart';

class TextModal extends StatefulWidget {
  final Function getSetting;
  final String settingName;

  const TextModal(
      {super.key, required this.getSetting, required this.settingName});

  @override
  State<StatefulWidget> createState() => _TextModalState();
}

class _TextModalState extends State<TextModal> {
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
    tfControl.text = widget.getSetting();

    return AlertDialog(
      title: Text('Question ${widget.settingName}'),
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
