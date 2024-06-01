import 'package:logger/logger.dart' show Level, Logger;
import 'package:path_provider/path_provider.dart';

Logger _logger = Logger(level: Level.debug);

class Storage {
  final String fileName = 'voice_msg.wav';

  Storage._internal();
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;
  static Storage get instance => _instance;

  String downloads = '';

  Future<void> init() async {
    requestDownloadsDirPath();
    _logger.d('Storage initialized');
  }

  void requestDownloadsDirPath() async {
    downloads = (await getDownloadsDirectory())!.path;
  }

  String getRecodingPath() {
    if (downloads.isEmpty) {
      requestDownloadsDirPath();
    }

    var filePath = '$downloads/$fileName';

    return filePath;
  }

}
