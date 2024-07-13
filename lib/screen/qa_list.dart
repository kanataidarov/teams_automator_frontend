import '../grpc/interview_automator/openai_api.pbenum.dart';
import '../widget/error_page.dart';
import '../widget/waiting_page.dart';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/qa_modal.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:logger/logger.dart' show Level, Logger;
import 'package:settings_ui/settings_ui.dart';

Logger _logger = Logger(level: Level.debug);

class QaList extends StatefulWidget {
  const QaList({super.key});

  @override
  State<StatefulWidget> createState() => _QaListState();
}

class _QaListState extends State<QaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions & Answers')),
      drawer: const DrawerWidget(),
      body: _qaList(context),
      floatingActionButton: FloatingActionButton(
          onPressed: _addQa, tooltip: 'New Q&A', child: const Icon(Icons.add)),
    );
  }

  Widget _qaList(BuildContext context) {
    return FutureBuilder<List<Qa>>(
        future: _fetchQas(),
        builder: (BuildContext ctx, AsyncSnapshot<List<Qa>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = SettingsList(sections: _sections(snapshot.data!));
          } else if (snapshot.hasError) {
            child = ErrorPage(snapshot: snapshot);
          } else {
            child = const WaitingPage();
          }
          return child;
        });
  }

  Future<List<Qa>> _fetchQas() async {
    final recs = await (await DbHelper.instance.database).query('qa');

    final List<Qa> qas = List.empty(growable: true);
    for (var stng in recs) {
      qas.add(Qa.fromMap(stng));
    }

    return qas;
  }

  List<SettingsSection> _sections(List<Qa> qas) {
    Map<Stage, List<SettingsTile>> tilesMap = {};
    for (var qa in qas) {
      if (!tilesMap.containsKey(qa.stage!)) {
        tilesMap[qa.stage!] = List.empty(growable: true);
      }
      tilesMap[qa.stage!]!.add(_card(context, qa));
    }

    List<SettingsSection> sections = List.empty(growable: true);
    for (var section in tilesMap.keys) {
      sections.add(SettingsSection(
          title: Text(toBeginningOfSentenceCase(section.name)),
          tiles: tilesMap[section]!));
    }
    return sections;
  }

  SettingsTile _card(BuildContext context, Qa qa) {
    return SettingsTile.navigation(
        title: Text(qa.title!),
        leading: const Icon(Icons.textsms_outlined),
        onPressed: (BuildContext context) {
          showDialog<Qa>(
              context: context,
              builder: (BuildContext context) => QaModal(qa: qa)).then((qa) {
            if (null != qa) {
              QaProvider.instance.update(qa).then((_) async {
                _logger.d('$qa updated');
              });
            }
          });
        });
  }

  void _addQa() {
    showDialog<Qa>(
        context: context,
        builder: (BuildContext context) {
          final emptyQa = Qa(question: '');
          return QaModal(qa: emptyQa);
        }).then((newQa) {
      if (null != newQa) {
        QaProvider.instance.insert(newQa).then((id) {
          setState(() {
            newQa.id = id;
          });
        });
      }
    });
  }
}
