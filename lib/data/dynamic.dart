import 'package:flutter/material.dart';

class TempData with ChangeNotifier {
  List<String> _answers = List.empty();
  List<String> getAnswers() => _answers;
  void setAnswers(final List<String> a) {
    _answers = a;
    notifyListeners();
  }

  String _model = 'gpt-4o';
  String getModel() => _model;
  void setModel(final String m) {
    _model = m;
    notifyListeners();
  }

  String _topic = 'Prepare Yourself to answer job interview questions.';
  String getTopic() => _topic;
  void setTopic(final String t) {
    _topic = t;
    notifyListeners();
  }

  String _transcription = 'Transcription empty.';
  String getTranscription() => _transcription;
  void setTranscription(final String t) {
    _transcription = t;
    notifyListeners();
  }

  final List<String> _questions = questions();
  int questionsLen() => _questions.length;
  String getQuestion(int i) => _questions[i];
  void updateQuestion(int i, String q) {
    _questions[i] = q;
    notifyListeners();
  }

  static List<String> questions() {
    return [
      """You have given part of interview session. Interview were held for middle java software developer position. Interview was in Russian.
 \nHere is text transcription of given interview part:
 \n{}
 \nExtract all questions asked by interviewer. """,
      """Extract answer to questions just extracted by you from given transcription part. Generate JSON containing questions and answers.
 \nJSON structure should be following: { "interview_session": [ "question": "", "answer": "", ... ] } """
    ];
  }
}
