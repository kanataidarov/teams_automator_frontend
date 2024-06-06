import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
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
    _client = await _initGrpcClient();
    return _client!;
  }

  _initGrpcClient() async {
    final host = (await SettingsProvider.instance.byName('host')).value!;
    final port =
        int.parse((await SettingsProvider.instance.byName('port')).value!);
    final channel = ClientChannel(host,
        port: port,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    _client = OpenAiApiClient(channel);
    _logger.d('Remote service Client initialized');
  }

  Future<String> transcribe(final filePath) async {
    String transcription = '';

    var file = File(filePath);

    FileHeader header =
        FileHeader(name: filePath, size: Int64(file.lengthSync()));
    TranscribeRequest request =
        TranscribeRequest(header: header, data: file.readAsBytesSync());

    _logger.d('Sending request - ${request.header}');
    try {
      transcription = (await (await client).transcribe(request)).transcription;
      _logger.i('Response - $transcription');
    } on GrpcError catch (e) {
      _logger.e('Error sending TranscribeRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    return transcription;
  }

  Future<List<Answer>> chatBot(BuildContext ctx) async {
    final topic = (await SettingsProvider.instance.byName('topic')).value!;
    final model = (await SettingsProvider.instance.byName('model')).value!;
    final transcription =
        (await SettingsProvider.instance.byName('transcription')).value!;

    ChatBotRequest request = ChatBotRequest(
        topic: topic, model: model, questions: await _questions(transcription));

    List<Answer> answers = List.empty();

    try {
      answers = (await (await client).chatBot(request)).answers;
    } on GrpcError catch (e) {
      _logger.e('Error sending ChatBotRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    _logger.i('Response - ${answers.length} answers.\n$answers');
    return answers;
  }

  Future<List<Question>> _questions(String transcription) async {
    var qas = (await DbHelper.instance.database).query(Qa.tableName);

    List<Question> questions = List.empty(growable: true);
    for (var qaMap in await qas) {
      var qa = Qa.fromMap(qaMap);
      questions.add(Question(qid: qa.id, content: qa.question));
    }

    return questions;
  }
}
