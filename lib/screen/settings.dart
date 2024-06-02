import '../widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Settings'))),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: settings(ctx),
        ));
  }

  Widget settings(BuildContext ctx) {
    return SettingsList(sections: [
      SettingsSection(title: const Text('Questions'), tiles: [
        SettingsTile(
            title: const Text('Question 1'),
            leading: const Icon(Icons.abc_sharp)),
        SettingsTile(
            title: const Text('Question 2'),
            leading: const Icon(Icons.abc_sharp))
      ])
    ]);
  }
}
