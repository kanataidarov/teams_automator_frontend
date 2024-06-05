import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/db.dart';

class ReinitModal extends StatefulWidget {
  final String path;
  const ReinitModal({super.key, required this.path});

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
    _tfControl.text = widget.path;

    return AlertDialog(
      title: const Text('Initialization data path'),
      content: TextField(
          controller: _tfControl,
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
