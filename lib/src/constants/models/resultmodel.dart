import 'dart:convert';

class Result {
  int id;
  DateTime? endTime;
  double mark;
  DateTime? startTime;
  int? idExam;
  String? username;

  Result({
    required this.id,
    this.endTime,
    required this.mark,
    this.startTime,
    this.idExam,
    this.username,
  });

  factory Result.fromMap(Map<String, dynamic> map) {
    try {
      return Result(
        id: map['id'],
        endTime: map['end_time'] != null ? DateTime.tryParse(map['end_time']) : null,
        mark: map['mark']?.toDouble() ?? 0.0,
        startTime: map['start_time'] != null ? DateTime.tryParse(map['start_time']) : null,
        idExam: map['id_exam'],
        username: map['username'],
      );
    } catch (e) {
      throw Exception('Lỗi khi phân tích dữ liệu Result: $e');
    }
  }

  factory Result.fromJson(String json) {
    return Result.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'end_time': endTime?.toIso8601String() ?? '',
      'mark': mark,
      'start_time': startTime?.toIso8601String() ?? '',
      'id_exam': idExam ?? 0,
      'username': username ?? '',
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
