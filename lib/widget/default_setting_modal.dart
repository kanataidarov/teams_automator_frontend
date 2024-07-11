import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/style.dart';
import 'package:interview_automator_frontend/widget/vgap.dart';

class DefaultSettingModal extends StatefulWidget {
  final Setting setting;

  const DefaultSettingModal({super.key, required this.setting});

  @override
  State<StatefulWidget> createState() => _DefaultSettingModalState();
}

class _DefaultSettingModalState extends State<DefaultSettingModal> {
  late TextEditingController _tfControl;

  bool defaultVoicePath = true;

  @override
  void initState() {
    super.initState();
    _tfControl = TextEditingController();

    final val = widget.setting.value!.split(';');
    defaultVoicePath = bool.parse(val[0]);
    _tfControl.text = val[1];
  }

  @override
  void dispose() {
    _tfControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return AlertDialog(
        title: Text(widget.setting.title!),
        content: Column(children: <Widget>[
          Text(
            widget.setting.description!,
            style: ModalsStyle.descriptionStyle,
          ),
          const VGap(height: 18),
          Row(children: <Widget>[
            const Text('Default path'),
            const SizedBox(
              width: 18,
            ),
            Switch(
                value: defaultVoicePath,
                onChanged: (value) {
                  setState(() {
                    defaultVoicePath = !defaultVoicePath;
                  });
                })
          ]),
          const VGap(height: 18),
          Expanded(
            child: TextField(
              controller: _tfControl,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
            ),
          )
        ]),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Discard')),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx, '$defaultVoicePath;${_tfControl.text}');
              },
              child: const Text('Save'))
        ]);
  }
}
