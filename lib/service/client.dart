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

  Future<void> transcribe(final filePath) async {
    var file = File(filePath);

    FileHeader header =
        FileHeader(name: filePath, size: Int64(file.lengthSync()));
    TranscribeRequest request =
        TranscribeRequest(header: header, data: file.readAsBytesSync());

    _logger.d('Sending request - ${request.header}');
    try {
      var response = await _client.transcribe(request);
      _logger.i('Response - ${response.transcription}');
    } on GrpcError catch (e) {
      _logger.e('Error sending TranscribeRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }
  }

  Future<void> chatBot() async {
    ChatBotRequest request = ChatBotRequest(
        topic: topic(), model: 'gpt-3.5-turbo', questions: questions());

    try {
      var response = await _client.chatBot(request);
      _logger.i('Response - ${response.answers.length} answers.\n${response.answers}');
    } on GrpcError catch (e) {
      _logger.e('Error sending ChatBotRequest - ${e.message}', error: e);
    } catch (e) {
      _logger.e('Unexpected error - ${e.toString()}', error: e);
    }
  }

  questions() {
    var transcription = """
    Исследования полиморфизм, инкапсуляция, конечно же. Ну, раз ты так акцентируешь инкапсуляцию, как ты понимаешь инкапсуляцию? Инкапсуляцию я понимаю как сокрытие ненужных данных от стороннего вмешательства. То есть, ну, то есть, ну, сокрытие данных, которые ненужны пользователю, например, чтобы, например, к переменам были доступы только через там сеттеры, гейтеры, чтобы к полям, например, не было доступа. А зачем? Чтобы извне не мог поменять то, что ему как бы на самом деле не надо. То есть, как бы принцип джавы, что написан какой-то метод, да, он внутри там пользует свои переменные. То есть, извне доступ, если не нужен, то как бы он внутри сокрывается. Ну, смотри, вот есть какой-то гейтер-сеттер, да, у меня. То есть, какой-то юзер, у него first name в поле стринга. Я таким, ну, если мы используем private и гейтер-сеттер, я пишу юзер.сетнейм и Ваня, а так я пишу юзер.нейм равно Ване. В чем проблема? Какая разница? Ну, потому что, ну, принято вообще пользоваться private переменами. Если в полях, ну, так, почему так проблема? Надо подумать на самом деле. Смотри, допустим, вот мы разрабатываем с тобой, допустим, у нас есть какой-то банковский аккаунт. У этого аккаунта есть поле баланса. А, то есть гейтер-сеттер можно дополнительными этими, ну, настроить, например. Функционалами, да? Да, дополнительным функционалом, точно. Отлично, да. То есть, смотри, допустим, у меня есть директор предприятия, и к нему мы можем либо дать доступ, чтобы все хоть заходили в кабинет, кто попал, и он устанет. Либо мы сами все контролируем, кто может к нему когда обращаться. О, да, верно. Отлично, хорошо. Я тоже так имел в виду. Ну, хорошо. С принципами, ну, в принципе, думаю, понятно. Пойдемте я дальше. Вот у нас есть примитивные типы данных и ссылочные. Какие между ними ключевые отличия? Так, между ними различия, они, насколько раньше знаю, хранятся в различных областях памяти в Java машине. Так, ссылочные переменные сравниваются, ну, например, если можно примитивы через оператор сравнения сравнивать. Ссылочные не будет сравнивать, просто ссылка указывает на один и тот же объект или нет. Хорошо, я понял. А вот у меня есть, допустим, примитивные типы данных, int, например. Есть какой-то диапазон значений, минимальное, максимальное. Откуда берется это значение? Ну вот, оно занимает определенное количество байт. Например, integer там занимает 16 байт, по-моему, или 8.
    """;

    return [
      """You have given part of interview session. Interview were held for middle java software developer position. Interview was in Russian.
 \nHere is text transcription of given interview part:
 \n$transcription
 \nExtract all questions asked by interviewer. """,
      """Extract answer to questions just extracted by you from given transcription part. Generate JSON containing questions and answers.
 \nJSON structure should be following: { "interview_session": [ "question": "", "answer": "", ... ] } """
    ];
  }

  String topic() {
    return 'Prepare Yourself to answer job interview questions.';
  }
}
