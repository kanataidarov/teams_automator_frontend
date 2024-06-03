import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/data/dynamic.dart';
import 'package:interview_automator_frontend/widget/drawer.dart';
import 'package:interview_automator_frontend/widget/text_modal.dart';
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
        appBar: AppBar(title: const Text('Settings')),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: settings(context),
        ));
  }

  Widget settings(BuildContext ctx) {
    var data = ctx.read<TempData>();

    return SettingsList(sections: [
      SettingsSection(title: const Text('ChatBot'), tiles: [
        textModal(ctx, data.getTopic, data.setTopic, 'Model'),
        textModal(ctx, data.getModel, data.setModel, 'Topic')
      ])
    ]);
  }

  SettingsTile textModal(BuildContext ctx, Function getSetting,
      Function setSetting, String settingName) {
    return SettingsTile.navigation(
        title: Text(settingName),
        leading: const Icon(Icons.textsms_outlined),
        onPressed: (BuildContext ctx) {
          showDialog<String>(
              context: ctx,
              builder: (BuildContext ctx) => TextModal(
                  getSetting: getSetting,
                  settingName: settingName)).then((val) {
            if (null != val) {
              setSetting(val);
            }
          });
        });
  }
}
