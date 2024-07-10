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
  late Question_AnswerType _selectedAnstype;
  late Stage _selectedStage;
  late int _ord;

  @override
  void initState() {
    _questionControl = TextEditingController();
    _qparamControl = TextEditingController();
    _answerControl = TextEditingController();

    final qa = widget.qa;
    _selectedAnstype = null == qa.anstype
        ? Question_AnswerType.RAW
        : Question_AnswerType.values[qa.anstype!];
    _selectedStage = null == qa.stage ? Stage.theory : qa.stage!;

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

    Future<List<Qa>> fetchQa(Stage stage) async {
      if (qa.title?.isEmpty ?? true) {
        final res = (await DbHelper.instance.database).rawQuery(
            'SELECT MAX(ord) as max_ord FROM ${Qa.tableName} WHERE stage = \'${stage.name}\'');
        // next order number for new record
        _ord = ((await res)[0]['max_ord'] as int) + 1;
        return [qa];
      }
      return [qa];
    }

    buildInt() => <Widget>[
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Stage', border: OutlineInputBorder()),
              items: Stage.values.map((Stage item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name))
                    ]));
              }).toList(),
              onChanged: (Stage? selectedStage) {
                fetchQa(selectedStage!).then((_) {
                  setState(() {
                    _selectedStage = selectedStage;
                  });
                });
              },
              value: _selectedStage),
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
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Answer type', border: OutlineInputBorder()),
              items: Question_AnswerType.values.map((Question_AnswerType item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name))
                    ]));
              }).toList(),
              onChanged: (Question_AnswerType? selectedItem) {
                setState(() {
                  _selectedAnstype = selectedItem!;
                });
              },
              value: _selectedAnstype),
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
      title: Text(null == qa.title ? 'New Q&A' : qa.title!),
      content: FutureBuilder<List<Qa>>(
          future: fetchQa(_selectedStage),
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
              if (qa.title?.isEmpty ?? true) {
                qa.ord = _ord;
                qa.title =
                    'Q&A ${toBeginningOfSentenceCase(_selectedStage.name)} $_ord';
              }
              qa.question = _questionControl.text;
              qa.qparam = _qparamControl.text;
              qa.anstype = _selectedAnstype.value;
              qa.stage = _selectedStage;
              Navigator.pop(ctx, qa);
            },
            child: const Text('Save'))
      ],
    );
  }
}
