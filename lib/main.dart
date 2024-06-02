import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/data/dynamic.dart';
import 'package:interview_automator_frontend/screen/home.dart';
import 'package:interview_automator_frontend/screen/settings.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => TempData())],
        child: const MyApp()),
  );
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
        '/settings': (ctx) => const SettingsPage()
      },
    );
  }
}
