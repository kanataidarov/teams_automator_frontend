//
//  Generated code. Do not modify.
//  source: interview_automator/openai_api.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use stageDescriptor instead')
const Stage$json = {
  '1': 'Stage',
  '2': [
    {'1': 'DEFAULT_STAGE', '2': 0},
    {'1': 'THEORY', '2': 1},
    {'1': 'LIVECODING', '2': 2},
    {'1': 'SOFTSKILLS', '2': 3},
  ],
};

/// Descriptor for `Stage`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List stageDescriptor = $convert.base64Decode(
    'CgVTdGFnZRIRCg1ERUZBVUxUX1NUQUdFEAASCgoGVEhFT1JZEAESDgoKTElWRUNPRElORxACEg'
    '4KClNPRlRTS0lMTFMQAw==');

@$core.Deprecated('Use qIntentDescriptor instead')
const QIntent$json = {
  '1': 'QIntent',
  '2': [
    {'1': 'DEFAULT_INTENT', '2': 0},
    {'1': 'CLARIFY', '2': 1},
    {'1': 'SOLVE', '2': 2},
    {'1': 'CORRECT', '2': 3},
  ],
};

/// Descriptor for `QIntent`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List qIntentDescriptor = $convert.base64Decode(
    'CgdRSW50ZW50EhIKDkRFRkFVTFRfSU5URU5UEAASCwoHQ0xBUklGWRABEgkKBVNPTFZFEAISCw'
    'oHQ09SUkVDVBAD');

@$core.Deprecated('Use transcribeRequestDescriptor instead')
const TranscribeRequest$json = {
  '1': 'TranscribeRequest',
  '2': [
    {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.interview_automator.FileHeader', '10': 'header'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'is_debug', '3': 3, '4': 1, '5': 8, '10': 'isDebug'},
  ],
};

/// Descriptor for `TranscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transcribeRequestDescriptor = $convert.base64Decode(
    'ChFUcmFuc2NyaWJlUmVxdWVzdBI3CgZoZWFkZXIYASABKAsyHy5pbnRlcnZpZXdfYXV0b21hdG'
    '9yLkZpbGVIZWFkZXJSBmhlYWRlchISCgRkYXRhGAIgASgMUgRkYXRhEhkKCGlzX2RlYnVnGAMg'
    'ASgIUgdpc0RlYnVn');

@$core.Deprecated('Use fileHeaderDescriptor instead')
const FileHeader$json = {
  '1': 'FileHeader',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'size', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'size', '17': true},
  ],
  '8': [
    {'1': '_size'},
  ],
};

/// Descriptor for `FileHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileHeaderDescriptor = $convert.base64Decode(
    'CgpGaWxlSGVhZGVyEhIKBG5hbWUYASABKAlSBG5hbWUSFwoEc2l6ZRgCIAEoA0gAUgRzaXpliA'
    'EBQgcKBV9zaXpl');

@$core.Deprecated('Use transcribeResponseDescriptor instead')
const TranscribeResponse$json = {
  '1': 'TranscribeResponse',
  '2': [
    {'1': 'transcription', '3': 1, '4': 1, '5': 9, '10': 'transcription'},
  ],
};

/// Descriptor for `TranscribeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transcribeResponseDescriptor = $convert.base64Decode(
    'ChJUcmFuc2NyaWJlUmVzcG9uc2USJAoNdHJhbnNjcmlwdGlvbhgBIAEoCVINdHJhbnNjcmlwdG'
    'lvbg==');

@$core.Deprecated('Use chatBotRequestDescriptor instead')
const ChatBotRequest$json = {
  '1': 'ChatBotRequest',
  '2': [
    {'1': 'topic', '3': 1, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'model', '3': 2, '4': 1, '5': 9, '10': 'model'},
    {'1': 'questions', '3': 3, '4': 3, '5': 11, '6': '.interview_automator.Question', '10': 'questions'},
    {'1': 'is_debug', '3': 4, '4': 1, '5': 8, '10': 'isDebug'},
    {'1': 'stage', '3': 5, '4': 1, '5': 14, '6': '.interview_automator.Stage', '10': 'stage'},
    {'1': 'intent', '3': 6, '4': 1, '5': 14, '6': '.interview_automator.QIntent', '10': 'intent'},
    {'1': 'lang', '3': 7, '4': 1, '5': 9, '10': 'lang'},
  ],
};

/// Descriptor for `ChatBotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatBotRequestDescriptor = $convert.base64Decode(
    'Cg5DaGF0Qm90UmVxdWVzdBIUCgV0b3BpYxgBIAEoCVIFdG9waWMSFAoFbW9kZWwYAiABKAlSBW'
    '1vZGVsEjsKCXF1ZXN0aW9ucxgDIAMoCzIdLmludGVydmlld19hdXRvbWF0b3IuUXVlc3Rpb25S'
    'CXF1ZXN0aW9ucxIZCghpc19kZWJ1ZxgEIAEoCFIHaXNEZWJ1ZxIwCgVzdGFnZRgFIAEoDjIaLm'
    'ludGVydmlld19hdXRvbWF0b3IuU3RhZ2VSBXN0YWdlEjQKBmludGVudBgGIAEoDjIcLmludGVy'
    'dmlld19hdXRvbWF0b3IuUUludGVudFIGaW50ZW50EhIKBGxhbmcYByABKAlSBGxhbmc=');

@$core.Deprecated('Use questionDescriptor instead')
const Question$json = {
  '1': 'Question',
  '2': [
    {'1': 'qid', '3': 1, '4': 1, '5': 5, '10': 'qid'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'ans_type', '3': 3, '4': 1, '5': 14, '6': '.interview_automator.Question.AnswerType', '10': 'ansType'},
  ],
  '4': [Question_AnswerType$json],
};

@$core.Deprecated('Use questionDescriptor instead')
const Question_AnswerType$json = {
  '1': 'AnswerType',
  '2': [
    {'1': 'DEFAULT_ANSTYPE', '2': 0},
    {'1': 'RAW', '2': 1},
    {'1': 'JSON_ONLY', '2': 2},
    {'1': 'SNIPPET', '2': 3},
  ],
};

/// Descriptor for `Question`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List questionDescriptor = $convert.base64Decode(
    'CghRdWVzdGlvbhIQCgNxaWQYASABKAVSA3FpZBIYCgdjb250ZW50GAIgASgJUgdjb250ZW50Ek'
    'MKCGFuc190eXBlGAMgASgOMiguaW50ZXJ2aWV3X2F1dG9tYXRvci5RdWVzdGlvbi5BbnN3ZXJU'
    'eXBlUgdhbnNUeXBlIkYKCkFuc3dlclR5cGUSEwoPREVGQVVMVF9BTlNUWVBFEAASBwoDUkFXEA'
    'ESDQoJSlNPTl9PTkxZEAISCwoHU05JUFBFVBAD');

@$core.Deprecated('Use chatBotResponseDescriptor instead')
const ChatBotResponse$json = {
  '1': 'ChatBotResponse',
  '2': [
    {'1': 'answers', '3': 1, '4': 3, '5': 11, '6': '.interview_automator.Answer', '10': 'answers'},
    {'1': 'stage', '3': 2, '4': 1, '5': 14, '6': '.interview_automator.Stage', '10': 'stage'},
    {'1': 'lang', '3': 3, '4': 1, '5': 9, '10': 'lang'},
  ],
};

/// Descriptor for `ChatBotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatBotResponseDescriptor = $convert.base64Decode(
    'Cg9DaGF0Qm90UmVzcG9uc2USNQoHYW5zd2VycxgBIAMoCzIbLmludGVydmlld19hdXRvbWF0b3'
    'IuQW5zd2VyUgdhbnN3ZXJzEjAKBXN0YWdlGAIgASgOMhouaW50ZXJ2aWV3X2F1dG9tYXRvci5T'
    'dGFnZVIFc3RhZ2USEgoEbGFuZxgDIAEoCVIEbGFuZw==');

@$core.Deprecated('Use answerDescriptor instead')
const Answer$json = {
  '1': 'Answer',
  '2': [
    {'1': 'qid', '3': 1, '4': 1, '5': 5, '10': 'qid'},
    {'1': 'content', '3': 2, '4': 1, '5': 9, '10': 'content'},
    {'1': 'extracted', '3': 3, '4': 1, '5': 9, '10': 'extracted'},
  ],
};

/// Descriptor for `Answer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerDescriptor = $convert.base64Decode(
    'CgZBbnN3ZXISEAoDcWlkGAEgASgFUgNxaWQSGAoHY29udGVudBgCIAEoCVIHY29udGVudBIcCg'
    'lleHRyYWN0ZWQYAyABKAlSCWV4dHJhY3RlZA==');

