import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';

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
          Row(children: <Widget>[
            const Text('Default path'),
            const SizedBox(
              width: 18,
            ),
            CupertinoSwitch(
                value: defaultVoicePath,
                onChanged: (value) {
                  setState(() {
                    defaultVoicePath = !defaultVoicePath;
                  });
                })
          ]),
          const SizedBox(
            height: 18,
          ),
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
