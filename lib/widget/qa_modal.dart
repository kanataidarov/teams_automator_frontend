import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/error_page.dart';
import 'package:interview_automator_frontend/widget/style.dart';
import 'package:interview_automator_frontend/widget/waiting_page.dart';
import 'package:intl/intl.dart';

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

    Future<List<Qa>> fetchQa() async {
      if (null == qa.ord) {
        // TODO make stage, anstype choosable
        qa.stage = 'theory';
        qa.anstype = Question_AnswerType.RAW.value;
        final res = (await DbHelper.instance.database).rawQuery(
            'SELECT MAX(ord) as max_ord FROM ${Qa.tableName} WHERE stage = "${qa.stage}"');
        // next order number for new record
        qa.ord = ((await res)[0]['max_ord'] as int) + 1;
        return [qa];
      }
      return [qa];
    }

    buildInt() => <Widget>[
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

    return AlertDialog(
      title: Text(null != qa.ord ? qa.title! : 'New Q&A'),
      content: FutureBuilder<List<Qa>>(
          future: fetchQa(),
          builder: (BuildContext ctx, AsyncSnapshot<List<Qa>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = Column(children: buildInt());
            } else if (snapshot.hasError) {
              child = ErrorPage(snapshot: snapshot);
            } else {
              child = const WaitingPage();
            }
            return child;
          }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Discard')),
        TextButton(
            onPressed: () {
              qa.title ??=
                  'Q&A ${toBeginningOfSentenceCase(qa.stage)} ${qa.ord}';
              qa.question = _questionControl.text;
              qa.qparam = _qparamControl.text;
              Navigator.pop(ctx, qa);
            },
            child: const Text('Save'))
      ],
    );
  }
}
