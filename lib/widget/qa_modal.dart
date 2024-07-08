import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/style.dart';

class QaModal extends StatefulWidget {
  final Qa qa;

  const QaModal({super.key, required this.qa});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<QaModal> {
  late TextEditingController _questionControl;
  late TextEditingController _qparamControl;
  late TextEditingController _answerControl;
  late int _currentOrd;

  @override
  void initState() {
    _questionControl = TextEditingController();
    _qparamControl = TextEditingController();
    _answerControl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _questionControl.dispose();
    _qparamControl.dispose();
    _answerControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final qa = widget.qa;

    _questionControl.text = qa.question!;
    _qparamControl.text = (qa.qparam?.isEmpty ?? true) ? '' : qa.qparam!;
    _answerControl.text = (qa.answer?.isEmpty ?? true) ? '' : qa.answer!;

    Future<int> currentOrd() async {
      int? currentOrd;
      if (null != qa.ord) {
        currentOrd = qa.ord!;
      } else {
        final res = (await DbHelper.instance.database)
            .rawQuery('SELECT MAX(ord) as max_ord FROM ${Qa.tableName}');
        // next order number for new record
        currentOrd = ((await res)[0]['max_ord'] as int) + 1;
      }

      setState(() {
        _currentOrd = currentOrd!;
      });
      return currentOrd;
    }

    normal() => <Widget>[
          Text(
            'Stage: ${qa.stage!}',
            style: ModalsStyle.descriptionStyle,
          ),
          const SizedBox(
            height: 9,
          ),
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
          const Text(
            'Question params',
            style: ModalsStyle.descriptionStyle,
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
          const SizedBox(
            height: 9,
          ),
          Text(
            'Answer type: ${Question_AnswerType.values[qa.anstype!].name}',
            style: ModalsStyle.descriptionStyle,
          ),
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: TextField(
              controller: _answerControl,
              expands: true,
              maxLines: null,
              readOnly: true,
            ),
          )
        ];

    error(AsyncSnapshot<int> snapshot) => <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          ),
        ];

    waiting() => const <Widget>[
          SizedBox(
            width: 99,
            height: 99,
            child: CircularProgressIndicator(),
          )
        ];

    return AlertDialog(
      title: Text(null != qa.ord ? qa.title! : 'New Q&A'),
      content: FutureBuilder<int>(
          future: currentOrd(),
          builder: (BuildContext ctx, AsyncSnapshot<int> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = normal();
            } else if (snapshot.hasError) {
              children = error(snapshot);
            } else {
              children = waiting();
            }
            return Column(children: children);
          }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Discard')),
        TextButton(
            onPressed: () {
              qa.title ??= 'Q&A $_currentOrd';
              qa.ord ??= _currentOrd;
              qa.question = _questionControl.text;
              qa.qparam = _qparamControl.text;
              Navigator.pop(ctx, qa);
            },
            child: const Text('Save'))
      ],
    );
  }
}
