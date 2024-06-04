import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';

class QaModal extends StatefulWidget {
  final Qa qa;

  const QaModal({super.key, required this.qa});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<QaModal> {
  late TextEditingController _questionControl;
  late TextEditingController _qparamControl;

  @override
  void initState() {
    _questionControl = TextEditingController();
    _qparamControl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _questionControl.dispose();
    _qparamControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    _questionControl.text = widget.qa.question!;
    _qparamControl.text = null == widget.qa.qparam ? '' : widget.qa.qparam!;

    return AlertDialog(
      title: Text(widget.qa.title!),
      content: Column(children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionControl,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        Expanded(
          child: TextField(
            controller: _qparamControl,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
          ),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              widget.qa.question = _questionControl.text;
              widget.qa.qparam = _qparamControl.text;
              Navigator.pop(ctx, widget.qa);
            },
            child: const Text('OK'))
      ],
    );
  }
}
