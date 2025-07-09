import 'dart:convert';

class Exam {
  int id;
  DateTime? createDate;
  bool? free;
  String? idName;
  DateTime? lastModify;
  String? nameExam;
  int time;
  int turn;
  int view;
  int? lessonId;
  String? usersId;

  Exam({
    required this.id,
    this.createDate,
    this.free,
    this.idName,
    this.lastModify,
    this.nameExam,
    required this.time,
    required this.turn,
    required this.view,
    this.lessonId,
    this.usersId,
  });

  factory Exam.fromMap(Map<String, dynamic> map) {
    try {
      return Exam(
        id: map['id'],
        createDate: map['create_date'] != null ? DateTime.tryParse(map['create_date']) : null,
        free: map['free'] == 1,  // Assuming 'bit(1)' is represented by 1 or 0 in the map
        idName: map['id_name'],
        lastModify: map['last_modify'] != null ? DateTime.tryParse(map['last_modify']) : null,
        nameExam: map['name_exam'],
        time: map['time'],
        turn: map['turn'],
        view: map['view'],
        lessonId: map['lesson_id'],
        usersId: map['users_id'],
      );
    } catch (e) {
      throw Exception('Error parsing Exam data: $e');
    }
  }

  factory Exam.fromJson(String json) {
    return Exam.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'create_date': createDate?.toIso8601String() ?? '',
      'free': free == true ? 1 : 0,  
      'id_name': idName ?? '',
      'last_modify': lastModify?.toIso8601String() ?? '',
      'name_exam': nameExam ?? '',
      'time': time,
      'turn': turn,
      'view': view,
      'lesson_id': lessonId ?? 0,
      'users_id': usersId ?? '',
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
