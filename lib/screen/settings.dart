import '../data/dynamic.dart';
import '../widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/widget/textitem_modal.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Settings'))),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: settings(context),
        ));
  }

  Widget settings(BuildContext ctx) {
    var data = ctx.read<TempData>();

    var n = data.questionsLen();
    var tiles = List<SettingsTile>.filled(
        n,
        SettingsTile(
          title: const Text(''),
        ));
    for (var i = 0; i < n; i++) {
      tiles[i] = textItemModal(ctx, data.getQuestion, data.updateQuestion, i);
    }

    return SettingsList(sections: [
      SettingsSection(title: const Text('Questions'), tiles: tiles)
    ]);
  }

  SettingsTile textItemModal(
      BuildContext ctx, Function getSetting, Function setSetting, int idx) {
    return SettingsTile.navigation(
        title: Text('Question $idx'),
        leading: const Icon(Icons.textsms_outlined),
        onPressed: (BuildContext ctx) {
          showDialog<String>(
              context: ctx,
              builder: (BuildContext ctx) =>
                  TextItemModal(getSetting: getSetting, idx: idx)).then((val) {
            if (null != val) {
              setSetting(idx, val);
            }
          });
        });
  }
}
