import 'package:logger/logger.dart' show Level, Logger;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Logger _logger = Logger(level: Level.debug);

class Files {
  final String _fileName = 'voice_msg.wav';

  Files._privateConstructor();
  static final Files instance = Files._privateConstructor();

  String _defaultDir = '';

  Future<void> init() async {
    _requestDirPath();
    _logger.d('Files initialized');
  }

  void _requestDirPath() async {
    _defaultDir = (await getApplicationDocumentsDirectory()).path;
  }

  String getDefaultRecodingPath() {
    if (_defaultDir.isEmpty) {
      _requestDirPath();
    }

    return join(_defaultDir, _fileName);
  }
}
