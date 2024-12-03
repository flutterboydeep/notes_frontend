import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotesModel {
  final String? id;
  final String? userid;
  final String? title;
  final String? content;
  final DateTime? date;
  NotesModel({
    this.id,
    this.userid,
    this.title,
    this.content,
    this.date,
  });
  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] != null ? map['id'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      date: DateTime.tryParse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'date': date!.toIso8601String(),
    };
  }

  // factory NotesModel.fromMap(Map<String, dynamic> map) {
  //   return NotesModel(
  //     userid: map['userid'] != null ? map['userid'] as String : null,
  //     title: map['title'] != null ? map['title'] as String : null,
  //     content: map['content'] != null ? map['content'] as String : null,
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory NotesModel.fromJson(String source) => NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
