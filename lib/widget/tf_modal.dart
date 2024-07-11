import 'package:flutter/material.dart';

class TfModal extends StatefulWidget {
  final String content;
  final String title;
  final bool readOnly;

  const TfModal(this.content, this.title, {super.key, this.readOnly = false});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<TfModal> {
  late TextEditingController _contentControl;

  @override
  void initState() {
    _contentControl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _contentControl.text = widget.content;

    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _contentControl,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        expands: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        readOnly: widget.readOnly,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(widget.readOnly ? 'Close' : 'Discard')),
        widget.readOnly
            ? Container()
            : TextButton(
                onPressed: () {
                  Navigator.pop(context, _contentControl.text);
                },
                child: const Text('Save'))
      ],
    );
  }
}
