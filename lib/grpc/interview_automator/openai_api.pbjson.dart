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

@$core.Deprecated('Use transcribeRequestDescriptor instead')
const TranscribeRequest$json = {
  '1': 'TranscribeRequest',
  '2': [
    {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.interview_automator.FileHeader', '10': 'header'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `TranscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transcribeRequestDescriptor = $convert.base64Decode(
    'ChFUcmFuc2NyaWJlUmVxdWVzdBI3CgZoZWFkZXIYASABKAsyHy5pbnRlcnZpZXdfYXV0b21hdG'
    '9yLkZpbGVIZWFkZXJSBmhlYWRlchISCgRkYXRhGAIgASgMUgRkYXRh');

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
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `TranscribeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transcribeResponseDescriptor = $convert.base64Decode(
    'ChJUcmFuc2NyaWJlUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use chatBotRequestDescriptor instead')
const ChatBotRequest$json = {
  '1': 'ChatBotRequest',
  '2': [
    {'1': 'topic', '3': 1, '4': 1, '5': 9, '10': 'topic'},
    {'1': 'messages', '3': 2, '4': 3, '5': 9, '10': 'messages'},
  ],
};

/// Descriptor for `ChatBotRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatBotRequestDescriptor = $convert.base64Decode(
    'Cg5DaGF0Qm90UmVxdWVzdBIUCgV0b3BpYxgBIAEoCVIFdG9waWMSGgoIbWVzc2FnZXMYAiADKA'
    'lSCG1lc3NhZ2Vz');

@$core.Deprecated('Use chatBotResponseDescriptor instead')
const ChatBotResponse$json = {
  '1': 'ChatBotResponse',
  '2': [
    {'1': 'messages', '3': 1, '4': 3, '5': 9, '10': 'messages'},
  ],
};

/// Descriptor for `ChatBotResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatBotResponseDescriptor = $convert.base64Decode(
    'Cg9DaGF0Qm90UmVzcG9uc2USGgoIbWVzc2FnZXMYASADKAlSCG1lc3NhZ2Vz');

