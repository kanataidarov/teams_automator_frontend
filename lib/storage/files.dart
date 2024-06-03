import 'package:logger/logger.dart' show Level, Logger;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Logger _logger = Logger(level: Level.debug);

class Files {
  final String fileName = 'voice_msg.wav';

  Files._privateConstructor();
  static final Files instance = Files._privateConstructor();

  String downloads = '';

  Future<void> init() async {
    _requestDirPath();
    _logger.d('Files initialized');
  }

  void _requestDirPath() async {
    downloads = (await getApplicationDocumentsDirectory()).path;
  }

  String getRecodingPath() {
    if (downloads.isEmpty) {
      _requestDirPath();
    }

    var filePath = join(downloads, fileName);

    return filePath;
  }

}
