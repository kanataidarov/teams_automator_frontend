//
//  Generated code. Do not modify.
//  source: interview_automator/openai_api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Stage extends $pb.ProtobufEnum {
  static const Stage DEFAULT_STAGE = Stage._(0, _omitEnumNames ? '' : 'DEFAULT_STAGE');
  static const Stage THEORY = Stage._(1, _omitEnumNames ? '' : 'THEORY');
  static const Stage LIVECODING = Stage._(2, _omitEnumNames ? '' : 'LIVECODING');
  static const Stage SOFTSKILLS = Stage._(3, _omitEnumNames ? '' : 'SOFTSKILLS');

  static const $core.List<Stage> values = <Stage> [
    DEFAULT_STAGE,
    THEORY,
    LIVECODING,
    SOFTSKILLS,
  ];

  static final $core.Map<$core.int, Stage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Stage? valueOf($core.int value) => _byValue[value];

  const Stage._($core.int v, $core.String n) : super(v, n);
}

class QIntent extends $pb.ProtobufEnum {
  static const QIntent DEFAULT_INTENT = QIntent._(0, _omitEnumNames ? '' : 'DEFAULT_INTENT');
  static const QIntent CLARIFY = QIntent._(1, _omitEnumNames ? '' : 'CLARIFY');
  static const QIntent SOLVE = QIntent._(2, _omitEnumNames ? '' : 'SOLVE');
  static const QIntent CORRECT = QIntent._(3, _omitEnumNames ? '' : 'CORRECT');

  static const $core.List<QIntent> values = <QIntent> [
    DEFAULT_INTENT,
    CLARIFY,
    SOLVE,
    CORRECT,
  ];

  static final $core.Map<$core.int, QIntent> _byValue = $pb.ProtobufEnum.initByValue(values);
  static QIntent? valueOf($core.int value) => _byValue[value];

  const QIntent._($core.int v, $core.String n) : super(v, n);
}

class Question_AnswerType extends $pb.ProtobufEnum {
  static const Question_AnswerType DEFAULT_ANSTYPE = Question_AnswerType._(0, _omitEnumNames ? '' : 'DEFAULT_ANSTYPE');
  static const Question_AnswerType RAW = Question_AnswerType._(1, _omitEnumNames ? '' : 'RAW');
  static const Question_AnswerType JSON_ONLY = Question_AnswerType._(2, _omitEnumNames ? '' : 'JSON_ONLY');
  static const Question_AnswerType SNIPPET = Question_AnswerType._(3, _omitEnumNames ? '' : 'SNIPPET');

  static const $core.List<Question_AnswerType> values = <Question_AnswerType> [
    DEFAULT_ANSTYPE,
    RAW,
    JSON_ONLY,
    SNIPPET,
  ];

  static final $core.Map<$core.int, Question_AnswerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Question_AnswerType? valueOf($core.int value) => _byValue[value];

  const Question_AnswerType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
