import 'package:interview_automator_frontend/storage/db.dart';
import 'package:logger/logger.dart' show Level, Logger;
import 'package:sqflite/sqflite.dart';

Logger _logger = Logger(level: Level.debug);

class Qa {
  static const tableName = 'qa';
  static const createScript = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        ord INTEGER NOT NULL,
        question TEXT NOT NULL,
        answer TEXT,
        qparam TEXT
      );''';

  static List<String> questions() {
    return [
      """You have given part of interview session. Interview were held for middle java software developer position. Interview was in Russian.      
\nHere is text transcription of given interview part:                                                                                             
\n{}                                                                                                                                              
\nExtract all questions asked by interviewer. """,
      """Extract answer to questions just extracted by you from given transcription part. Generate JSON containing questions and answers.          
\nJSON structure should be following: { "interview_session": [ "question": "", "answer": "", ... ] } """
    ];
  }

  int? id;
  String? title;
  int? ord;
  String? question;
  String? answer;
  String? qparam;

  Qa({this.id, this.title, this.ord, this.question, this.answer, this.qparam});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ord': ord,
      'question': question,
      'answer': answer,
      'qparam': qparam
    };
  }

  Qa.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    ord = map['ord'];
    question = map['question'];
    answer = map['answer'];
    qparam = map['qparam'];
  }

  @override
  String toString() => '${Qa.tableName}(Id=$id,title=`$title`,order=$ord)';
}

class QaProvider {
  final _dbHelper = DbHelper.instance;

  QaProvider._privateConstructor();
  static final QaProvider instance = QaProvider._privateConstructor();

  Future<int> insert(Qa qa) async {
    final db = await _dbHelper.database;
    final id = await db.insert(Qa.tableName, qa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    qa.id = id;
    _logger.d('Record $qa inserted');
    return id;
  }

  Future<void> update(Qa qa) async {
    final db = await _dbHelper.database;
    final count = await db
        .update(Qa.tableName, qa.toMap(), where: 'id = ?', whereArgs: [qa.id]);
    _logger.d('$count records updated in `${Qa.tableName}`');
  }

  Future<void> delete(Qa qa) async {
    final db = await _dbHelper.database;
    final count =
        await db.delete(Qa.tableName, where: 'id = ?', whereArgs: [qa.id]);
    _logger.d('$count records deleted in `${Qa.tableName}`');
  }
}
