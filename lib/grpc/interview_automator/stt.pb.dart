//
//  Generated code. Do not modify.
//  source: interview_automator/stt.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class SttRequest extends $pb.GeneratedMessage {
  factory SttRequest({
    FileHeader? header,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  SttRequest._() : super();
  factory SttRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SttRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SttRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOM<FileHeader>(1, _omitFieldNames ? '' : 'header', subBuilder: FileHeader.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SttRequest clone() => SttRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SttRequest copyWith(void Function(SttRequest) updates) => super.copyWith((message) => updates(message as SttRequest)) as SttRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SttRequest create() => SttRequest._();
  SttRequest createEmptyInstance() => create();
  static $pb.PbList<SttRequest> createRepeated() => $pb.PbList<SttRequest>();
  @$core.pragma('dart2js:noInline')
  static SttRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SttRequest>(create);
  static SttRequest? _defaultInstance;

  @$pb.TagNumber(1)
  FileHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(FileHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  FileHeader ensureHeader() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

class FileHeader extends $pb.GeneratedMessage {
  factory FileHeader({
    $core.String? name,
    $fixnum.Int64? size,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (size != null) {
      $result.size = size;
    }
    return $result;
  }
  FileHeader._() : super();
  factory FileHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileHeader', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'size')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileHeader clone() => FileHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileHeader copyWith(void Function(FileHeader) updates) => super.copyWith((message) => updates(message as FileHeader)) as FileHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileHeader create() => FileHeader._();
  FileHeader createEmptyInstance() => create();
  static $pb.PbList<FileHeader> createRepeated() => $pb.PbList<FileHeader>();
  @$core.pragma('dart2js:noInline')
  static FileHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileHeader>(create);
  static FileHeader? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get size => $_getI64(1);
  @$pb.TagNumber(2)
  set size($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => clearField(2);
}

class SttResponse extends $pb.GeneratedMessage {
  factory SttResponse({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SttResponse._() : super();
  factory SttResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SttResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SttResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SttResponse clone() => SttResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SttResponse copyWith(void Function(SttResponse) updates) => super.copyWith((message) => updates(message as SttResponse)) as SttResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SttResponse create() => SttResponse._();
  SttResponse createEmptyInstance() => create();
  static $pb.PbList<SttResponse> createRepeated() => $pb.PbList<SttResponse>();
  @$core.pragma('dart2js:noInline')
  static SttResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SttResponse>(create);
  static SttResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
