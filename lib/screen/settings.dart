import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/reinit_modal.dart';
import 'package:interview_automator_frontend/widget/setting_modal.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:settings_ui/settings_ui.dart';

Logger _logger = Logger(level: Level.debug);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: settings(context),
        ));
  }

  error(AsyncSnapshot<List<Setting>> snapshot) => Column(children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: ${snapshot.error}'),
        )
      ]);

  waiting() => const SizedBox(
        width: 99,
        height: 99,
        child: CircularProgressIndicator(),
      );

  normal(List<Setting> s) => SettingsList(sections: _buildTiles(s));

  Widget settings(BuildContext context) {
    return FutureBuilder<List<Setting>>(
        future: _fetchSettings(),
        builder: (BuildContext ctx, AsyncSnapshot<List<Setting>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = normal(snapshot.data!);
          } else if (snapshot.hasError) {
            child = error(snapshot);
          } else {
            child = waiting();
          }
          return child;
        });
  }

  SettingsTile _buildModal(Setting setting) {
    return SettingsTile.navigation(
        title: Text(setting.title!),
        leading: const Icon(Icons.textsms_outlined),
        onPressed: (BuildContext context) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return 'init_file_path' != setting.name
                    ? SettingModal(setting: setting)
                    : ReinitModal(path: setting.value!);
              }).then((newVal) {
            if (newVal != null) {
              setting.value = newVal;
              SettingsProvider.instance.update(setting);
            }
          });
        });
  }

  Future<List<Setting>> _fetchSettings() async {
    var recs = (await DbHelper.instance.database).query('settings');

    final List<Setting> stngs = List.empty(growable: true);
    for (var stngRec in await recs) {
      var stng = Setting.fromMap(stngRec);
      stngs.add(stng);
    }

    return stngs;
  }

  List<SettingsSection> _buildTiles(List<Setting> stngs) {
    Map<String, List<SettingsTile>> tilesMap = {};
    for (var stng in stngs) {
      if (!tilesMap.containsKey(stng.section!)) {
        tilesMap[stng.section!] = List.empty(growable: true);
        tilesMap[stng.section!]!.add(_buildModal(stng));
      } else {
        tilesMap[stng.section!]!.add(_buildModal(stng));
      }
    }

    List<SettingsSection> sections = List.empty(growable: true);
    for (var section in tilesMap.keys) {
      sections.add(
          SettingsSection(title: Text(section), tiles: tilesMap[section]!));
    }
    return sections;
  }
}
