import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:interview_automator_frontend/storage/model/qa.dart';
import 'package:interview_automator_frontend/storage/model/settings.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class DbHelper {
  static const _dbName = 'interview_automator.db';
  static const _dbVer = 3;
  static const _defaultAssetsPath = 'assets/interview_automator_init.json';

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var path = join((await getApplicationDocumentsDirectory()).path, _dbName);

    var db = await openDatabase(path, version: _dbVer);

    _logger.d('Database opened at ${db.path}');
    return db;
  }

  Future close() async => _database!.close();

  Future<Map<String, dynamic>> loadJson(String path) async {
    String jsonStr = '';
    try {
      if (_defaultAssetsPath == path) {
        jsonStr = await rootBundle.loadString(path);
      } else {
        File file = File(path);
        jsonStr = await file.readAsString();
      }
    } catch (e) {
      _logger.e('Error occurred loading settings file', error: e);
    }
    return await json.decode(jsonStr);
  }

  Future<void> recreateSchemaAndLoadData(String path) async {
    final Map<String, dynamic> data;
    try {
      data = await loadJson(path);
    } catch (e) {
      _logger.e('Error decoding json', error: e);
      return;
    }

    await SettingsProvider.instance.recreateTable(data["settings"]);
    await QaProvider.instance.recreateTable(data["qa"]);
  }
}
