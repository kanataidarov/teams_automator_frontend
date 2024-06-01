import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:interview_automator_frontend/grpc/interview_automator/openai_api.pbgrpc.dart';

Logger _logger = Logger(level: Level.debug);

class ClientService {
  ClientService._internal();
  static final ClientService _instance = ClientService._internal();
  factory ClientService() => _instance;
  static ClientService get instance => _instance;

  final String baseUrl = '192.168.8.10';

  late OpenAiApiClient _client;

  Future<void> init() async {
    _createChannel();
    _logger.d('Remote service Client initialized');
  }

  OpenAiApiClient get getClient {
    return _client;
  }

  _createChannel() {
    final channel = ClientChannel(baseUrl,
        port: 44045,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
    _client = OpenAiApiClient(channel);
  }

  Future<void> recognize(final filePath) async {
    try {
      var file = File(filePath);

      FileHeader header =
          FileHeader(name: filePath, size: Int64(file.lengthSync()));
      TranscribeRequest request =
          TranscribeRequest(header: header, data: file.readAsBytesSync());

      var response = await _client.transcribe(request);
      _logger.i('Response - ${response.message}');
    } on GrpcError catch (e) {
      _logger.e('Error sending SttRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }
  }
}
