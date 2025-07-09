class Document {
  final int id;
  final String? avatar;
  final String? content;
  final DateTime? createDate;  // Change type to DateTime
  final String? title;
  final int view;
  final int? subjectId;
  final String? userId;

  Document({
    required this.id,
    this.avatar,
    this.content,
    this.createDate,
    this.title,
    required this.view,
    this.subjectId,
    this.userId,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      avatar: json['avatar'],
      content: json['content'],
      // If create_date is not null, parse it into DateTime
      createDate: json['create_date'] != null
          ? DateTime.parse(json['create_date'])
          : null,
      title: json['title'],
      view: json['view'],
      subjectId: json['subject_id'],
      userId: json['user_id'],
    );
  }
}
