import 'dart:convert';

class Subject {
  int id;
  String? image;
  String? name;

  Subject({
    required this.id,
    this.image,
    this.name,
  });

  // Hàm chuyển Map<String, dynamic> thành đối tượng Subject
  factory Subject.fromMap(Map<String, dynamic> map) {
    try {
      return Subject(
        id: map['id'],           // Lấy giá trị id từ map
        image: map['image'],     // Lấy giá trị image từ map
        name: map['name'],       // Lấy giá trị name từ map
      );
    } catch (e) {
      throw Exception('Error parsing Subject data: $e');
    }
  }

  // Hàm chuyển đổi từ chuỗi JSON thành đối tượng Subject
  factory Subject.fromJson(String json) {
    return Subject.fromMap(jsonDecode(json));  // Giải mã chuỗi JSON thành Map và truyền vào fromMap
  }

  // Chuyển đối tượng Subject thành Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,                          // Trả về id
      'image': image ?? '',              // Trả về image nếu có, nếu không trả về chuỗi rỗng
      'name': name ?? '',                // Trả về name nếu có, nếu không trả về chuỗi rỗng
    };
  }

  // Chuyển đối tượng Subject thành chuỗi JSON
  String toJson() {
    return jsonEncode(toMap());  // Chuyển map thành chuỗi JSON
  }
}
