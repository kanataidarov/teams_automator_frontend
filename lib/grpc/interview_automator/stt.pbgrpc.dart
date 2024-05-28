//
//  Generated code. Do not modify.
//  source: interview_automator/stt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'stt.pb.dart' as $0;

export 'stt.pb.dart';

@$pb.GrpcServiceName('interview_automator.SpeechToText')
class SpeechToTextClient extends $grpc.Client {
  static final _$recognize = $grpc.ClientMethod<$0.SttRequest, $0.SttResponse>(
      '/interview_automator.SpeechToText/Recognize',
      ($0.SttRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SttResponse.fromBuffer(value));

  SpeechToTextClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SttResponse> recognize($0.SttRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$recognize, request, options: options);
  }
}

@$pb.GrpcServiceName('interview_automator.SpeechToText')
abstract class SpeechToTextServiceBase extends $grpc.Service {
  $core.String get $name => 'interview_automator.SpeechToText';

  SpeechToTextServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SttRequest, $0.SttResponse>(
        'Recognize',
        recognize_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SttRequest.fromBuffer(value),
        ($0.SttResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SttResponse> recognize_Pre($grpc.ServiceCall call, $async.Future<$0.SttRequest> request) async {
    return recognize(call, await request);
  }

  $async.Future<$0.SttResponse> recognize($grpc.ServiceCall call, $0.SttRequest request);
}
