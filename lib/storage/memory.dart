import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbenum.dart';

class Memory with ChangeNotifier {
  Question_Stage _lastStage = Question_Stage.THEORY;
  Question_Stage get lastStage => _lastStage;
  void setStage(final Question_Stage stage) {
    _lastStage = stage;
    notifyListeners();
  }
}
