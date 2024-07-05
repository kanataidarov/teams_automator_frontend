import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/widget/style.dart';

import '../storage/model/settings.dart';

class ReinitModal extends StatefulWidget {
  final Setting setting;
  const ReinitModal({super.key, required this.setting});

  @override
  State<StatefulWidget> createState() => _ReinitModalState();
}

class _ReinitModalState extends State<ReinitModal> {
  late TextEditingController _tfControl;

  @override
  void initState() {
    super.initState();

    _tfControl = TextEditingController();
  }

  @override
  void dispose() {
    _tfControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    _tfControl.text = widget.setting.value!;

    return AlertDialog(
      title: Text(widget.setting.title!),
      content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.setting.description!,
              style: ModalsStyle.descriptionStyle,
            ),
            const SizedBox(
              height: 9,
            ),
            Expanded(
                child: TextField(
                    controller: _tfControl,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true))
          ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              DbHelper.instance
                  .recreateSchemaAndLoadData(_tfControl.text)
                  .then((_) {
                Navigator.pop(ctx, _tfControl.text);
              });
            },
            child: const Text('Reinit settings'))
      ],
    );
  }
}
