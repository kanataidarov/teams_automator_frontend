import 'package:flutter/material.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pb.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbenum.dart';

class Memory with ChangeNotifier {
  Stage _lastStage = Stage.THEORY;
  Stage get lastStage => _lastStage;
  void setStage(final Stage stage) {
    _lastStage = stage;
    notifyListeners();
  }
}
