//
//  Generated code. Do not modify.
//  source: teams_automator/openai_api.proto
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

import 'openai_api.pb.dart' as $0;

export 'openai_api.pb.dart';

@$pb.GrpcServiceName('interview_automator.OpenAiApi')
class OpenAiApiClient extends $grpc.Client {
  static final _$transcribe = $grpc.ClientMethod<$0.TranscribeRequest, $0.TranscribeResponse>(
      '/interview_automator.OpenAiApi/Transcribe',
      ($0.TranscribeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TranscribeResponse.fromBuffer(value));

  OpenAiApiClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.TranscribeResponse> transcribe($0.TranscribeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transcribe, request, options: options);
  }
}

@$pb.GrpcServiceName('interview_automator.OpenAiApi')
abstract class OpenAiApiServiceBase extends $grpc.Service {
  $core.String get $name => 'interview_automator.OpenAiApi';

  OpenAiApiServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TranscribeRequest, $0.TranscribeResponse>(
        'Transcribe',
        transcribe_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TranscribeRequest.fromBuffer(value),
        ($0.TranscribeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.TranscribeResponse> transcribe_Pre($grpc.ServiceCall call, $async.Future<$0.TranscribeRequest> request) async {
    return transcribe(call, await request);
  }

  $async.Future<$0.TranscribeResponse> transcribe($grpc.ServiceCall call, $0.TranscribeRequest request);
}
