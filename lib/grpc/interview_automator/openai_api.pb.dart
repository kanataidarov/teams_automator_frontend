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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'openai_api.pbenum.dart';

export 'openai_api.pbenum.dart';

class TranscribeRequest extends $pb.GeneratedMessage {
  factory TranscribeRequest({
    FileHeader? header,
    $core.List<$core.int>? data,
    $core.bool? isDebug,
  }) {
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (data != null) {
      $result.data = data;
    }
    if (isDebug != null) {
      $result.isDebug = isDebug;
    }
    return $result;
  }
  TranscribeRequest._() : super();
  factory TranscribeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranscribeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranscribeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOM<FileHeader>(1, _omitFieldNames ? '' : 'header', subBuilder: FileHeader.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'isDebug')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranscribeRequest clone() => TranscribeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranscribeRequest copyWith(void Function(TranscribeRequest) updates) => super.copyWith((message) => updates(message as TranscribeRequest)) as TranscribeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranscribeRequest create() => TranscribeRequest._();
  TranscribeRequest createEmptyInstance() => create();
  static $pb.PbList<TranscribeRequest> createRepeated() => $pb.PbList<TranscribeRequest>();
  @$core.pragma('dart2js:noInline')
  static TranscribeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranscribeRequest>(create);
  static TranscribeRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.bool get isDebug => $_getBF(2);
  @$pb.TagNumber(3)
  set isDebug($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsDebug() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsDebug() => clearField(3);
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

class TranscribeResponse extends $pb.GeneratedMessage {
  factory TranscribeResponse({
    $core.String? transcription,
  }) {
    final $result = create();
    if (transcription != null) {
      $result.transcription = transcription;
    }
    return $result;
  }
  TranscribeResponse._() : super();
  factory TranscribeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranscribeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranscribeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transcription')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranscribeResponse clone() => TranscribeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranscribeResponse copyWith(void Function(TranscribeResponse) updates) => super.copyWith((message) => updates(message as TranscribeResponse)) as TranscribeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranscribeResponse create() => TranscribeResponse._();
  TranscribeResponse createEmptyInstance() => create();
  static $pb.PbList<TranscribeResponse> createRepeated() => $pb.PbList<TranscribeResponse>();
  @$core.pragma('dart2js:noInline')
  static TranscribeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranscribeResponse>(create);
  static TranscribeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transcription => $_getSZ(0);
  @$pb.TagNumber(1)
  set transcription($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTranscription() => $_has(0);
  @$pb.TagNumber(1)
  void clearTranscription() => clearField(1);
}

class Prompt extends $pb.GeneratedMessage {
  factory Prompt({
    $core.String? extract,
    $core.String? theoryIntro,
    $core.String? theoryOutro,
    $core.String? livecodingIntro,
    $core.String? livecodingOutro,
    $core.String? softskillsIntro,
    $core.String? softskillsOutro,
  }) {
    final $result = create();
    if (extract != null) {
      $result.extract = extract;
    }
    if (theoryIntro != null) {
      $result.theoryIntro = theoryIntro;
    }
    if (theoryOutro != null) {
      $result.theoryOutro = theoryOutro;
    }
    if (livecodingIntro != null) {
      $result.livecodingIntro = livecodingIntro;
    }
    if (livecodingOutro != null) {
      $result.livecodingOutro = livecodingOutro;
    }
    if (softskillsIntro != null) {
      $result.softskillsIntro = softskillsIntro;
    }
    if (softskillsOutro != null) {
      $result.softskillsOutro = softskillsOutro;
    }
    return $result;
  }
  Prompt._() : super();
  factory Prompt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Prompt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Prompt', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'extract')
    ..aOS(2, _omitFieldNames ? '' : 'theoryIntro')
    ..aOS(3, _omitFieldNames ? '' : 'theoryOutro')
    ..aOS(4, _omitFieldNames ? '' : 'livecodingIntro')
    ..aOS(5, _omitFieldNames ? '' : 'livecodingOutro')
    ..aOS(6, _omitFieldNames ? '' : 'softskillsIntro')
    ..aOS(7, _omitFieldNames ? '' : 'softskillsOutro')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Prompt clone() => Prompt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Prompt copyWith(void Function(Prompt) updates) => super.copyWith((message) => updates(message as Prompt)) as Prompt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Prompt create() => Prompt._();
  Prompt createEmptyInstance() => create();
  static $pb.PbList<Prompt> createRepeated() => $pb.PbList<Prompt>();
  @$core.pragma('dart2js:noInline')
  static Prompt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Prompt>(create);
  static Prompt? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get extract => $_getSZ(0);
  @$pb.TagNumber(1)
  set extract($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasExtract() => $_has(0);
  @$pb.TagNumber(1)
  void clearExtract() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get theoryIntro => $_getSZ(1);
  @$pb.TagNumber(2)
  set theoryIntro($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTheoryIntro() => $_has(1);
  @$pb.TagNumber(2)
  void clearTheoryIntro() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get theoryOutro => $_getSZ(2);
  @$pb.TagNumber(3)
  set theoryOutro($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTheoryOutro() => $_has(2);
  @$pb.TagNumber(3)
  void clearTheoryOutro() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get livecodingIntro => $_getSZ(3);
  @$pb.TagNumber(4)
  set livecodingIntro($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLivecodingIntro() => $_has(3);
  @$pb.TagNumber(4)
  void clearLivecodingIntro() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get livecodingOutro => $_getSZ(4);
  @$pb.TagNumber(5)
  set livecodingOutro($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLivecodingOutro() => $_has(4);
  @$pb.TagNumber(5)
  void clearLivecodingOutro() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get softskillsIntro => $_getSZ(5);
  @$pb.TagNumber(6)
  set softskillsIntro($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSoftskillsIntro() => $_has(5);
  @$pb.TagNumber(6)
  void clearSoftskillsIntro() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get softskillsOutro => $_getSZ(6);
  @$pb.TagNumber(7)
  set softskillsOutro($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSoftskillsOutro() => $_has(6);
  @$pb.TagNumber(7)
  void clearSoftskillsOutro() => clearField(7);
}

class ChatBotRequest extends $pb.GeneratedMessage {
  factory ChatBotRequest({
    $core.String? topic,
    $core.String? model,
    $core.Iterable<Question>? questions,
    $core.bool? isDebug,
    Stage? stage,
    QIntent? intent,
    $core.String? lang,
    Prompt? prompt,
  }) {
    final $result = create();
    if (topic != null) {
      $result.topic = topic;
    }
    if (model != null) {
      $result.model = model;
    }
    if (questions != null) {
      $result.questions.addAll(questions);
    }
    if (isDebug != null) {
      $result.isDebug = isDebug;
    }
    if (stage != null) {
      $result.stage = stage;
    }
    if (intent != null) {
      $result.intent = intent;
    }
    if (lang != null) {
      $result.lang = lang;
    }
    if (prompt != null) {
      $result.prompt = prompt;
    }
    return $result;
  }
  ChatBotRequest._() : super();
  factory ChatBotRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatBotRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatBotRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'topic')
    ..aOS(2, _omitFieldNames ? '' : 'model')
    ..pc<Question>(3, _omitFieldNames ? '' : 'questions', $pb.PbFieldType.PM, subBuilder: Question.create)
    ..aOB(4, _omitFieldNames ? '' : 'isDebug')
    ..e<Stage>(5, _omitFieldNames ? '' : 'stage', $pb.PbFieldType.OE, defaultOrMaker: Stage.DEFAULT_STAGE, valueOf: Stage.valueOf, enumValues: Stage.values)
    ..e<QIntent>(6, _omitFieldNames ? '' : 'intent', $pb.PbFieldType.OE, defaultOrMaker: QIntent.DEFAULT_INTENT, valueOf: QIntent.valueOf, enumValues: QIntent.values)
    ..aOS(7, _omitFieldNames ? '' : 'lang')
    ..aOM<Prompt>(8, _omitFieldNames ? '' : 'prompt', subBuilder: Prompt.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatBotRequest clone() => ChatBotRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatBotRequest copyWith(void Function(ChatBotRequest) updates) => super.copyWith((message) => updates(message as ChatBotRequest)) as ChatBotRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatBotRequest create() => ChatBotRequest._();
  ChatBotRequest createEmptyInstance() => create();
  static $pb.PbList<ChatBotRequest> createRepeated() => $pb.PbList<ChatBotRequest>();
  @$core.pragma('dart2js:noInline')
  static ChatBotRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatBotRequest>(create);
  static ChatBotRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get topic => $_getSZ(0);
  @$pb.TagNumber(1)
  set topic($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTopic() => $_has(0);
  @$pb.TagNumber(1)
  void clearTopic() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get model => $_getSZ(1);
  @$pb.TagNumber(2)
  set model($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasModel() => $_has(1);
  @$pb.TagNumber(2)
  void clearModel() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Question> get questions => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get isDebug => $_getBF(3);
  @$pb.TagNumber(4)
  set isDebug($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsDebug() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsDebug() => clearField(4);

  @$pb.TagNumber(5)
  Stage get stage => $_getN(4);
  @$pb.TagNumber(5)
  set stage(Stage v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStage() => $_has(4);
  @$pb.TagNumber(5)
  void clearStage() => clearField(5);

  @$pb.TagNumber(6)
  QIntent get intent => $_getN(5);
  @$pb.TagNumber(6)
  set intent(QIntent v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasIntent() => $_has(5);
  @$pb.TagNumber(6)
  void clearIntent() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get lang => $_getSZ(6);
  @$pb.TagNumber(7)
  set lang($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLang() => $_has(6);
  @$pb.TagNumber(7)
  void clearLang() => clearField(7);

  @$pb.TagNumber(8)
  Prompt get prompt => $_getN(7);
  @$pb.TagNumber(8)
  set prompt(Prompt v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrompt() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrompt() => clearField(8);
  @$pb.TagNumber(8)
  Prompt ensurePrompt() => $_ensure(7);
}

class Question extends $pb.GeneratedMessage {
  factory Question({
    $core.int? qid,
    $core.String? content,
    Question_AnswerType? ansType,
  }) {
    final $result = create();
    if (qid != null) {
      $result.qid = qid;
    }
    if (content != null) {
      $result.content = content;
    }
    if (ansType != null) {
      $result.ansType = ansType;
    }
    return $result;
  }
  Question._() : super();
  factory Question.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Question.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Question', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'qid', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..e<Question_AnswerType>(3, _omitFieldNames ? '' : 'ansType', $pb.PbFieldType.OE, defaultOrMaker: Question_AnswerType.DEFAULT_ANSTYPE, valueOf: Question_AnswerType.valueOf, enumValues: Question_AnswerType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Question clone() => Question()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Question copyWith(void Function(Question) updates) => super.copyWith((message) => updates(message as Question)) as Question;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Question create() => Question._();
  Question createEmptyInstance() => create();
  static $pb.PbList<Question> createRepeated() => $pb.PbList<Question>();
  @$core.pragma('dart2js:noInline')
  static Question getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Question>(create);
  static Question? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get qid => $_getIZ(0);
  @$pb.TagNumber(1)
  set qid($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQid() => $_has(0);
  @$pb.TagNumber(1)
  void clearQid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  Question_AnswerType get ansType => $_getN(2);
  @$pb.TagNumber(3)
  set ansType(Question_AnswerType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAnsType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnsType() => clearField(3);
}

class ChatBotResponse extends $pb.GeneratedMessage {
  factory ChatBotResponse({
    $core.Iterable<Answer>? answers,
    Stage? stage,
    $core.String? lang,
  }) {
    final $result = create();
    if (answers != null) {
      $result.answers.addAll(answers);
    }
    if (stage != null) {
      $result.stage = stage;
    }
    if (lang != null) {
      $result.lang = lang;
    }
    return $result;
  }
  ChatBotResponse._() : super();
  factory ChatBotResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatBotResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatBotResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..pc<Answer>(1, _omitFieldNames ? '' : 'answers', $pb.PbFieldType.PM, subBuilder: Answer.create)
    ..e<Stage>(2, _omitFieldNames ? '' : 'stage', $pb.PbFieldType.OE, defaultOrMaker: Stage.DEFAULT_STAGE, valueOf: Stage.valueOf, enumValues: Stage.values)
    ..aOS(3, _omitFieldNames ? '' : 'lang')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatBotResponse clone() => ChatBotResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatBotResponse copyWith(void Function(ChatBotResponse) updates) => super.copyWith((message) => updates(message as ChatBotResponse)) as ChatBotResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatBotResponse create() => ChatBotResponse._();
  ChatBotResponse createEmptyInstance() => create();
  static $pb.PbList<ChatBotResponse> createRepeated() => $pb.PbList<ChatBotResponse>();
  @$core.pragma('dart2js:noInline')
  static ChatBotResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatBotResponse>(create);
  static ChatBotResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Answer> get answers => $_getList(0);

  @$pb.TagNumber(2)
  Stage get stage => $_getN(1);
  @$pb.TagNumber(2)
  set stage(Stage v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStage() => $_has(1);
  @$pb.TagNumber(2)
  void clearStage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lang => $_getSZ(2);
  @$pb.TagNumber(3)
  set lang($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLang() => $_has(2);
  @$pb.TagNumber(3)
  void clearLang() => clearField(3);
}

class Answer extends $pb.GeneratedMessage {
  factory Answer({
    $core.int? qid,
    $core.String? content,
    $core.String? extracted,
  }) {
    final $result = create();
    if (qid != null) {
      $result.qid = qid;
    }
    if (content != null) {
      $result.content = content;
    }
    if (extracted != null) {
      $result.extracted = extracted;
    }
    return $result;
  }
  Answer._() : super();
  factory Answer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Answer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Answer', package: const $pb.PackageName(_omitMessageNames ? '' : 'interview_automator'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'qid', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'content')
    ..aOS(3, _omitFieldNames ? '' : 'extracted')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Answer clone() => Answer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Answer copyWith(void Function(Answer) updates) => super.copyWith((message) => updates(message as Answer)) as Answer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Answer create() => Answer._();
  Answer createEmptyInstance() => create();
  static $pb.PbList<Answer> createRepeated() => $pb.PbList<Answer>();
  @$core.pragma('dart2js:noInline')
  static Answer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Answer>(create);
  static Answer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get qid => $_getIZ(0);
  @$pb.TagNumber(1)
  set qid($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQid() => $_has(0);
  @$pb.TagNumber(1)
  void clearQid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get content => $_getSZ(1);
  @$pb.TagNumber(2)
  set content($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContent() => $_has(1);
  @$pb.TagNumber(2)
  void clearContent() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get extracted => $_getSZ(2);
  @$pb.TagNumber(3)
  set extracted($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExtracted() => $_has(2);
  @$pb.TagNumber(3)
  void clearExtracted() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
