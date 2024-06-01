import 'package:flutter/material.dart';

class TempData with ChangeNotifier {
  List<String> _answers = List.empty();
  List<String> get answers => _answers;
  void updateAnswers(final List<String> a) {
    _answers = a;
    notifyListeners();
  }

  String _model = 'gpt-4o';
  String get model => _model;
  void updateModel(final String m) {
    _model = m;
    notifyListeners();
  }

  String _topic = 'Prepare Yourself to answer job interview questions.';
  String get topic => _topic;
  void updateTopic(final String t) {
    _topic = t;
    notifyListeners();
  }

  String _transcription = 'Prepare Yourself to answer job interview questions.';
  String get transcription => _transcription;
  void updateTranscription(final String t) {
    _transcription = t;
    notifyListeners();
  }
}
