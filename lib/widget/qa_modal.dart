import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/error_page.dart';
import 'package:interview_automator_frontend/widget/waiting_page.dart';
import 'package:intl/intl.dart';

class QaModal extends StatefulWidget {
  final Qa qa;

  const QaModal({super.key, required this.qa});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<QaModal> {
  late TextEditingController _answerControl;
  late TextEditingController _dialogueControl;
  late TextEditingController _questionControl;
  late Question_AnswerType _selectedAnstype;
  late Question_Intent _selectedIntent;
  late Question_Stage _selectedStage;
  late int _ord;

  @override
  void initState() {
    _questionControl = TextEditingController();
    _dialogueControl = TextEditingController();
    _answerControl = TextEditingController();

    final qa = widget.qa;
    _selectedAnstype =
        null == qa.anstype ? Question_AnswerType.RAW : qa.anstype!;
    _selectedIntent = null == qa.qintent ? Question_Intent.SOLVE : qa.qintent!;
    _selectedStage = null == qa.stage ? Question_Stage.THEORY : qa.stage!;

    super.initState();
  }

  @override
  void dispose() {
    _answerControl.dispose();
    _dialogueControl.dispose();
    _questionControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final qa = widget.qa;

    _answerControl.text = (qa.answer?.isEmpty ?? true) ? ' ' : qa.answer!;
    _dialogueControl.text = (qa.dialogue?.isEmpty ?? true) ? ' ' : qa.dialogue!;
    _questionControl.text = qa.question!;

    Future<List<Qa>> fetchQa(Question_Stage stage) async {
      if (qa.title?.isEmpty ?? true) {
        final res = (await DbHelper.instance.database).rawQuery(
            'SELECT MAX(ord) as max_ord FROM ${Qa.tableName} WHERE stage = \'${stage.name}\'');
        // next order number for new record
        _ord = ((await res)[0]['max_ord'] as int) + 1;
        return [qa];
      }
      return [qa];
    }

    buildInt() => Column(children: <Widget>[
          Expanded(
            child: TextField(
              controller: _questionControl,
              decoration: const InputDecoration(
                  labelText: 'Question', border: OutlineInputBorder()),
              expands: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Stage', border: OutlineInputBorder()),
              items: Question_Stage.values.map((Question_Stage item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name.toLowerCase()))
                    ]));
              }).toList(),
              onChanged: (Question_Stage? selectedStage) {
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
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Answer type', border: OutlineInputBorder()),
              items: Question_AnswerType.values.map((Question_AnswerType item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name.toLowerCase()))
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
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Intent', border: OutlineInputBorder()),
              items: Question_Intent.values.map((Question_Intent item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name.toLowerCase()))
                    ]));
              }).toList(),
              onChanged: (Question_Intent? selectedItem) {
                setState(() {
                  _selectedIntent = selectedItem!;
                });
              },
              value: _selectedIntent),
          const SizedBox(
            height: 9,
          ),
          TextField(
            decoration: const InputDecoration(
                labelText: 'Last answer', border: OutlineInputBorder()),
            controller: _answerControl,
            maxLines: 1,
            readOnly: true,
          ),
          const SizedBox(
            height: 9,
          ),
          TextField(
              decoration: const InputDecoration(
                  labelText: 'Full dialogue', border: OutlineInputBorder()),
              controller: _dialogueControl,
              maxLines: 1,
              readOnly: true),
        ]);

    return AlertDialog(
      title: Text(null == qa.title ? 'New Q&A' : qa.title!),
      content: FutureBuilder<List<Qa>>(
          future: fetchQa(_selectedStage),
          builder: (BuildContext ctx, AsyncSnapshot<List<Qa>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = buildInt();
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
              qa.anstype = _selectedAnstype;
              qa.qintent = _selectedIntent;
              qa.stage = _selectedStage;
              qa.question = _questionControl.text;
              Navigator.pop(ctx, qa);
            },
            child: const Text('Save'))
      ],
    );
  }
}
