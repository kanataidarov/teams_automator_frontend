abstract class DbModel {
  int? id;

  DbModel({this.id});

  Map<String, dynamic> toMap();

  DbModel.fromMap(Map<String, dynamic> map);
}
