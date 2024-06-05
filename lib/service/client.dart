import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbgrpc.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:provider/provider.dart';

import '../data/dynamic.dart';

Logger _logger = Logger(level: Level.debug);

class ClientService {
  ClientService._internal();
  static final ClientService _instance = ClientService._internal();
  factory ClientService() => _instance;
  static ClientService get instance => _instance;

  final String host = '192.168.8.10';

  late OpenAiApiClient _client;

  Future<void> init() async {
    _createChannel();
    _logger.d('Remote service Client initialized');
  }

  OpenAiApiClient get getClient {
    return _client;
  }

  _createChannel() {
    final channel = ClientChannel(host,
        port: 44045,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    _client = OpenAiApiClient(channel);
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
      transcription = (await _client.transcribe(request)).transcription;
      _logger.i('Response - $transcription');
    } on GrpcError catch (e) {
      _logger.e('Error sending TranscribeRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    return transcription;
  }

  Future<List<String>> chatBot(BuildContext ctx) async {
    var data = ctx.read<TempData>();

    ChatBotRequest request = ChatBotRequest(
        topic: data.getTopic(),
        model: data.getModel(),
        questions: questions(data.getTranscription()));

    List<String> answers = List.empty();

    try {
      var response = await _client.chatBot(request);
      answers = response.answers;
    } on GrpcError catch (e) {
      _logger.e('Error sending ChatBotRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }

    _logger.i('Response - ${answers.length} answers.\n$answers');
    return answers;
  }

  questions(String transcription) {
    _logger.d('Transcription - $transcription');

    return [
      """You have given part of interview session. Interview were held for middle java software developer position. Interview was in Russian.
 \nHere is text transcription of given interview part:
 \n$transcription
 \nExtract all questions asked by interviewer. """,
      """Extract answer to questions just extracted by you from given transcription part. Generate JSON containing questions and answers.
 \nJSON structure should be following: { "interview_session": [ "question": "", "answer": "", ... ] } """
    ];
  }
}
