import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/screen/home.dart';
import 'package:interview_automator_frontend/screen/qa_list.dart';
import 'package:interview_automator_frontend/screen/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interview Automator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MyHomePage(),
        '/settings': (ctx) => const SettingsPage(),
        '/qa': (ctx) => const QaList()
      },
    );
  }
}
