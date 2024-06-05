import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';

class SettingModal extends StatefulWidget {
  final Setting setting;

  const SettingModal({super.key, required this.setting});

  @override
  State<StatefulWidget> createState() => _SettingModalState();
}

class _SettingModalState extends State<SettingModal> {
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
    tfControl.text = widget.setting.value!;

    return AlertDialog(
      title: Text(widget.setting.title!),
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
            child: const Text('Discard')),
        TextButton(
            onPressed: () {
              Navigator.pop(ctx, tfControl.text);
            },
            child: const Text('Save'))
      ],
    );
  }
}
