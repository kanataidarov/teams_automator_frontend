import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/style.dart';

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
    final setting = widget.setting;
    tfControl.text = setting.value!;

    return AlertDialog(
      title: Text(setting.title!),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              setting.description!,
              style: ModalsStyle.descriptionStyle,
            ),
            const SizedBox(
              height: 9,
            ),
            Expanded(
                child: InputField(tfControl: tfControl, type: setting.type!))
          ]),
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

class InputField extends StatelessWidget {
  final TextEditingController tfControl;
  final String type;

  const InputField({super.key, required this.tfControl, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'integer':
        return TextField(
          controller: tfControl,
          keyboardType: TextInputType.number,
          maxLines: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );
      case 'string':
        return TextField(
            controller: tfControl,
            keyboardType: TextInputType.text,
            maxLines: 1);
      default:
        return TextField(
            controller: tfControl,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true);
    }
  }
}
