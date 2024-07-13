import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/error_page.dart';
import 'package:interview_automator_frontend/widget/tf_modal.dart';
import 'package:interview_automator_frontend/widget/vgap.dart';
import 'package:interview_automator_frontend/widget/waiting_page.dart';
import 'package:intl/intl.dart';

class QaModal extends StatefulWidget {
  final Qa qa;

  const QaModal({super.key, required this.qa});

  @override
  State<StatefulWidget> createState() => _QaModalState();
}

class _QaModalState extends State<QaModal> {
  late Map<String, TextEditingController> _controllers;
  late Question_AnswerType _selectedAnstype;
  late QIntent _selectedIntent;
  late Stage _selectedStage;
  late int _ord;

  @override
  void initState() {
    final qa = widget.qa;

    _controllers = {
      'Question': TextEditingController(text: qa.question),
      'Last answer': TextEditingController(
          text: (qa.answer?.isEmpty ?? true) ? ' ' : qa.answer!),
      'Full dialogue': TextEditingController(
          text: (qa.dialogue?.isEmpty ?? true) ? ' ' : qa.dialogue!),
      'Extracted questions': TextEditingController(
          text: (qa.extracted?.isEmpty ?? true) ? ' ' : qa.extracted!),
    };

    _selectedAnstype =
        null == qa.anstype ? Question_AnswerType.RAW : qa.anstype!;
    _selectedIntent = null == qa.qintent ? QIntent.SOLVE : qa.qintent!;
    _selectedStage = null == qa.stage ? Stage.THEORY : qa.stage!;

    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((_, v) => v.dispose);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final qa = widget.qa;

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

    Widget openOnDoubleTap(
            BuildContext context, final String label, bool isEditable) =>
        GestureDetector(
            child: isEditable
                ? TextField(
                    controller: _controllers[label],
                    decoration: InputDecoration(
                        labelText: label, border: const OutlineInputBorder()),
                    enabled:
                        !(_controllers[label]?.text.trim().isEmpty ?? true),
                    keyboardType: TextInputType.multiline,
                    maxLines: 9,
                    readOnly: true,
                  )
                : TextField(
                    decoration: InputDecoration(
                        labelText: label, border: const OutlineInputBorder()),
                    enabled:
                        !(_controllers[label]?.text.trim().isEmpty ?? true),
                    controller: _controllers[label],
                    maxLines: 1,
                    readOnly: true),
            onDoubleTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => TfModal(
                      _controllers[label]!.text, label,
                      readOnly: !isEditable)).then(
                (question) {
                  if (null != question) {
                    _controllers[label]!.text = question;
                  }
                },
              );
            });

    buildInt() => Column(children: <Widget>[
          openOnDoubleTap(context, 'Question', true),
          const VGap(),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Stage', border: OutlineInputBorder()),
              items: Stage.values.map((Stage item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name.toLowerCase()))
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
          const VGap(),
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
          const VGap(),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                  labelText: 'Intent', border: OutlineInputBorder()),
              items: QIntent.values.map((QIntent item) {
                return DropdownMenuItem(
                    value: item,
                    child: Row(children: [
                      const Icon(Icons.question_answer_outlined),
                      const SizedBox(width: 9),
                      Text(toBeginningOfSentenceCase(item.name.toLowerCase()))
                    ]));
              }).toList(),
              onChanged: (QIntent? selectedItem) {
                setState(() {
                  _selectedIntent = selectedItem!;
                });
              },
              value: _selectedIntent),
          const VGap(),
          openOnDoubleTap(context, 'Last answer', false),
          const VGap(),
          openOnDoubleTap(context, 'Full dialogue', false),
          const VGap(),
          openOnDoubleTap(context, 'Extracted questions', false)
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
              qa.question = _controllers['Question']!.text;
              Navigator.pop(ctx, qa);
            },
            child: const Text('Save'))
      ],
    );
  }
}
