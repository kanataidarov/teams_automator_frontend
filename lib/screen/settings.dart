import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/service/client.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:interview_automator_frontend/widget/default_setting_modal.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/reinit_modal.dart';
import 'package:interview_automator_frontend/widget/setting_modal.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:settings_ui/settings_ui.dart';
import '../widget/error_page.dart';
import '../widget/waiting_page.dart';

Logger _logger = Logger(level: Level.debug);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ValueNotifier<bool> _needRefreshSettings = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        drawer: const DrawerWidget(),
        body: _settings(context));
  }

  Widget _settings(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _needRefreshSettings,
        builder: (context, value, _) {
          return FutureBuilder<List<Setting>>(
              future: _fetchSettings(),
              builder:
                  (BuildContext ctx, AsyncSnapshot<List<Setting>> snapshot) {
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
        });
  }

  Future<List<Setting>> _fetchSettings() async {
    final recs = (await DbHelper.instance.database).query('settings');

    bool debugEnabled = await isDebugEnabled();

    final List<Setting> stngs = List.empty(growable: true);
    for (var stngRec in await recs) {
      var stng = Setting.fromMap(stngRec);

      if (!debugEnabled && 'hidden' == stng.section) {
        continue;
      }

      stngs.add(stng);
    }

    return stngs;
  }

  List<SettingsSection> _sections(List<Setting> stngs) {
    Map<String, List<SettingsTile>> tilesMap = {};
    for (var stng in stngs) {
      if (!tilesMap.containsKey(stng.section!)) {
        tilesMap[stng.section!] = List.empty(growable: true);
      }
      switch (stng.type) {
        case 'bool':
          tilesMap[stng.section!]!.add(_buildSwitch(stng));
          break;
        default:
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

  SettingsTile _buildModal(Setting setting) {
    return SettingsTile.navigation(
        title: Text(setting.title!),
        leading: const Icon(Icons.textsms_outlined),
        onPressed: (BuildContext context) {
          showDialog<String>(
              context: context,
              builder: (_) => _buildModalInt(setting)).then((newVal) {
            if (null != newVal) {
              setting.value = newVal;
              _update(setting);
            }
          });
        });
  }

  Widget _buildModalInt(Setting setting) {
    if ('init_file_path' == setting.name) {
      return ReinitModal(setting: setting);
    }
    switch (setting.type) {
      case 'default_text':
        return DefaultSettingModal(setting: setting);
      default:
        return SettingModal(setting: setting);
    }
  }

  SettingsTile _buildSwitch(Setting setting) {
    return SettingsTile.switchTile(
        initialValue: 'TRUE' == setting.value!.toUpperCase(),
        onToggle: (newVal) {
          setting.value = newVal ? 'true' : 'false';
          _update(setting);
        },
        title: Text(setting.title!),
        leading: const Icon(Icons.repeat_outlined));
  }

  void _update(Setting setting) {
    SettingsProvider.instance.update(setting).then((_) async {
      if ('Backend service' == setting.section) {
        ClientService.instance
            .setClient(await ClientService.instance.initGrpcClient());
      } else if ('init_file_path' == setting.name) {
        _needRefreshSettings.value = !_needRefreshSettings.value;
        _logger.i('Settings restored to defaults from `${setting.value}`');
      } else if ('debug_enabled' == setting.name) {
        _needRefreshSettings.value = !_needRefreshSettings.value;
      }
    });
  }
}

Future<bool> isDebugEnabled() async {
  var stng = (await SettingsProvider.instance.byName('debug_enabled')).value!;
  return bool.parse(stng, caseSensitive: false);
}
