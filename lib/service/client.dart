import 'dart:convert';
import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:format/format.dart';
import 'package:grpc/grpc.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbgrpc.dart';
import 'package:interview_automator_frontend/storage/db.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:logger/logger.dart' show Level, Logger;

Logger _logger = Logger(level: Level.debug);

class ClientService {
  ClientService._privateConstructor();
  static final ClientService instance = ClientService._privateConstructor();

  static OpenAiApiClient? _client;
  Future<OpenAiApiClient> get client async {
    if (_client != null) return _client!;
    _client = await initGrpcClient();
    _logger.d('Remote service Client initialized');
    return _client!;
  }

  void setClient(OpenAiApiClient c) {
    _client = c;
  }

  Future<OpenAiApiClient> initGrpcClient() async {
    final host = (await SettingsProvider.instance.byName('host')).value!;
    final port =
        int.parse((await SettingsProvider.instance.byName('port')).value!);
    final channel = ClientChannel(host,
        port: port,
        options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
            connectTimeout: Duration(seconds: 10)));
    _logger.d('Channel (re)initialized. Host - $host, port - $port');
    return OpenAiApiClient(channel);
  }

  Future<String> transcribe(final filePath) async {
    String transcription = '';

    final debugEnabled = bool.parse(
        (await SettingsProvider.instance.byName('debug_enabled')).value!);

    var file = File(filePath);

    FileHeader header =
        FileHeader(name: filePath, size: Int64(file.lengthSync()));
    TranscribeRequest request = TranscribeRequest(
        header: header, data: file.readAsBytesSync(), isDebug: debugEnabled);

    _logger.d('Sending request - ${request.header}');
    try {
      var cli = await client;
      transcription = (await cli.transcribe(request)).transcription;
      _logger.i('Response - $transcription');
    } on GrpcError catch (e) {
      _logger.e('Error sending TranscribeRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    return transcription;
  }

  Future<List<Answer>> chatBot(
      BuildContext ctx, String stage, String intent) async {
    final topic = (await SettingsProvider.instance.byName('topic')).value!;
    final model = (await SettingsProvider.instance.byName('model')).value!;
    final transcription =
        (await SettingsProvider.instance.byName('transcription')).value!;
    final debugEnabled = bool.parse(
        (await SettingsProvider.instance.byName('debug_enabled')).value!);

    ChatBotRequest request = ChatBotRequest(
        topic: topic,
        model: model,
        questions: await _questions(transcription, stage, intent),
        isDebug: debugEnabled);
    _logger.d('Sending request - $request');

    List<Answer> answers = List.empty();
    try {
      var cli = await client;
      answers = (await cli.chatBot(request)).answers;
    } on GrpcError catch (e) {
      _logger.e('Error sending ChatBotRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    _logger.i('Response - ${answers.length} answers.\n$answers');
    return answers;
  }

  Future<List<Question>> _questions(
      String transcription, String stage, String intent) async {
    var db = await DbHelper.instance.database;
    var qas = db.query(Qa.tableName,
        where: 'stage = ? and qintent = ?', whereArgs: [stage, intent]);

    var solveQa = await _solveQa(stage);

    List<Question> questions = List.empty(growable: true);
    for (var qaMap in await qas) {
      var qa = Qa.fromMap(qaMap);

      qa.question = _embedTexts(qa, solveQa, transcription);

      questions.add(Question(
          qid: qa.id,
          content: qa.question,
          ansType: qa.anstype,
          intent: qa.qintent,
          stage: qa.stage));
    }

    return questions;
  }

  String _embedTexts(Qa qa, Qa solveQa, String transcription) {
    switch (qa.qintent) {
      case Question_Intent.CLARIFY:
      case Question_Intent.CORRECT:
        return qa.question!.format({
          'transcription': transcription,
          'dialogue': solveQa.dialogue,
          'questions': solveQa.extracted
        });
      case Question_Intent.SOLVE:
        return qa.question!.format({'transcription': transcription});
      default:
        return qa.question!;
    }
  }

  void handleChatBot(BuildContext ctx, String stage, String intent) async {
    chatBot(ctx, stage, intent).then((answers) async {
      for (var answer in answers) {
        final qas = await (await DbHelper.instance.database)
            .query(Qa.tableName, where: 'id = ?', whereArgs: [answer.qid]);
        var qa = Qa.fromMap(qas.first);
        qa.answer = answer.content;
        qa.extracted = answer.extracted;
        await QaProvider.instance.update(qa);

        final root =
            jsonDecode(_extractJson(answer.content)) as Map<String, dynamic>;
        final items = root['interview_session'] as List;

        var solveQa = await _solveQa(stage);
        for (final item in items) {
          solveQa.dialogue =
              '${solveQa.dialogue} \nInterviewer: ${item['question']} '
              '\nCandidate: ${item['answer']}\n';
        }

        await QaProvider.instance.update(solveQa);
      }
    });
  }

  String _extractJson(String content) {
    content = ' $content';
    var idx = content.indexOf(RegExp(r'\{'));
    content = content.replaceRange(0, idx - 1, '');

    idx = content.lastIndexOf(RegExp(r'\}'));
    content = ('$content ').replaceRange(idx + 1, null, '');

    return content;
  }

  Future<Qa> _solveQa(String stage) async {
    final solveQas = (await DbHelper.instance.database).query(Qa.tableName,
        where: 'stage = ? and qintent = ?', whereArgs: [stage, 'SOLVE']);
    return Qa.fromMap((await solveQas).first);
  }
}
