import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:teams_automator_frontend/grpc/teams_automator/openai_api.pbgrpc.dart';
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
    const host = "192.168.8.185";
    const port = 44045;

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

    var file = File(filePath);

    FileHeader header =
        FileHeader(name: filePath, size: Int64(file.lengthSync()));
    TranscribeRequest request =
        TranscribeRequest(header: header, data: file.readAsBytesSync());

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
}
