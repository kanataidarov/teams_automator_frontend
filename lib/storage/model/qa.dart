class Qa {
  static const tableName = 'qa';
  static const script = '''CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        ord INTEGER NOT NULL,
        question TEXT NOT NULL,
        answer TEXT,
        qparam TEXT
      )''';

  final int? id;
  final String title;
  final int ord;
  final String question;
  final String? answer;
  final String? qparam;

  Qa(
      {this.id,
      required this.title,
      required this.ord,
      required this.question,
      this.answer,
      this.qparam});

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
}
