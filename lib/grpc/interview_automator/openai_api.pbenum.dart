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

class Question_AnswerType extends $pb.ProtobufEnum {
  static const Question_AnswerType RAW = Question_AnswerType._(0, _omitEnumNames ? '' : 'RAW');
  static const Question_AnswerType JSON_ONLY = Question_AnswerType._(1, _omitEnumNames ? '' : 'JSON_ONLY');
  static const Question_AnswerType SNIPPET = Question_AnswerType._(2, _omitEnumNames ? '' : 'SNIPPET');

  static const $core.List<Question_AnswerType> values = <Question_AnswerType> [
    RAW,
    JSON_ONLY,
    SNIPPET,
  ];

  static final $core.Map<$core.int, Question_AnswerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Question_AnswerType? valueOf($core.int value) => _byValue[value];

  const Question_AnswerType._($core.int v, $core.String n) : super(v, n);
}

class Question_Intent extends $pb.ProtobufEnum {
  static const Question_Intent CLARIFY = Question_Intent._(0, _omitEnumNames ? '' : 'CLARIFY');
  static const Question_Intent SOLVE = Question_Intent._(1, _omitEnumNames ? '' : 'SOLVE');
  static const Question_Intent CORRECT = Question_Intent._(2, _omitEnumNames ? '' : 'CORRECT');

  static const $core.List<Question_Intent> values = <Question_Intent> [
    CLARIFY,
    SOLVE,
    CORRECT,
  ];

  static final $core.Map<$core.int, Question_Intent> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Question_Intent? valueOf($core.int value) => _byValue[value];

  const Question_Intent._($core.int v, $core.String n) : super(v, n);
}

class Question_Stage extends $pb.ProtobufEnum {
  static const Question_Stage THEORY = Question_Stage._(0, _omitEnumNames ? '' : 'THEORY');
  static const Question_Stage LIVECODING = Question_Stage._(1, _omitEnumNames ? '' : 'LIVECODING');
  static const Question_Stage SOFTSKILLS = Question_Stage._(2, _omitEnumNames ? '' : 'SOFTSKILLS');

  static const $core.List<Question_Stage> values = <Question_Stage> [
    THEORY,
    LIVECODING,
    SOFTSKILLS,
  ];

  static final $core.Map<$core.int, Question_Stage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Question_Stage? valueOf($core.int value) => _byValue[value];

  const Question_Stage._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
