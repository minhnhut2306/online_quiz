class User {
  final String id;
  final String fullName;
  final String email;
  final String address;
  final String phoneNumber;
  final String img;
  final String passWord;
  final DateTime? createDate;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.img,
    required this.passWord,
    this.createDate,
  });

  // fromMap to create User object from Map (used when parsing API response as Map)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      fullName: map['full_name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      img: map['img'] ?? '',
      passWord: map['pass_word'] ?? '',
      createDate: map['create_date'] != null ? DateTime.parse(map['create_date']) : null,
    );
  }

  // fromJson to create User object from JSON (used when parsing API response in JSON format)
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      img: json['img'] ?? '',
      passWord: json['pass_word'] ?? '',
      createDate: json['create_date'] != null ? DateTime.parse(json['create_date']) : null,
    );
  }

  // Convert User object to Map (for sending data to API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'img': img,
      'pass_word': passWord,
      'create_date': createDate?.toIso8601String(),  // Convert DateTime to string
    };
  }

  // Convert User object to JSON (used when sending to API)
  Map<String, dynamic> toJson() {
    return toMap();  // Reuse toMap method for JSON representation
  }
}
