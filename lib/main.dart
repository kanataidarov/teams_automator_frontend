import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/screen/home.dart';
import 'package:interview_automator_frontend/screen/qa_list.dart';
import 'package:interview_automator_frontend/screen/settings.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/files.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DbHelper.instance.checkIfInit();
  Files.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Interview Automator';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MyHomePage(title: title),
        '/settings': (ctx) => const SettingsPage(),
        '/qa': (ctx) => const QaList()
      },
    );
  }
}
