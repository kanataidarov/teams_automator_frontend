//
//  Generated code. Do not modify.
//  source: interview_automator/stt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sttRequestDescriptor instead')
const SttRequest$json = {
  '1': 'SttRequest',
  '2': [
    {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.interview_automator.FileHeader', '10': 'header'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `SttRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sttRequestDescriptor = $convert.base64Decode(
    'CgpTdHRSZXF1ZXN0EjcKBmhlYWRlchgBIAEoCzIfLmludGVydmlld19hdXRvbWF0b3IuRmlsZU'
    'hlYWRlclIGaGVhZGVyEhIKBGRhdGEYAiABKAxSBGRhdGE=');

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

@$core.Deprecated('Use sttResponseDescriptor instead')
const SttResponse$json = {
  '1': 'SttResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SttResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sttResponseDescriptor = $convert.base64Decode(
    'CgtTdHRSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

