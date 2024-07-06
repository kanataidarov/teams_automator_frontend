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

  static const $core.List<Question_AnswerType> values = <Question_AnswerType> [
    RAW,
    JSON_ONLY,
  ];

  static final $core.Map<$core.int, Question_AnswerType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Question_AnswerType? valueOf($core.int value) => _byValue[value];

  const Question_AnswerType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
