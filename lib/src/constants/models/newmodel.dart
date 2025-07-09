class News {
  int? id;
  String? content;
  DateTime? createDate;
  String? image;
  DateTime? lastModify;
  String? title;
  int? view;
  String? author;

  News({
    this.id,
    this.content,
    this.createDate,
    this.image,
    this.lastModify,
    this.title,
    this.view,
    this.author,
  });

factory News.fromJson(Map<String, dynamic> json) {
  print("Raw lastModify from JSON: ${json['lastModify']}"); // Log để kiểm tra
  print("Raw createDate from JSON: ${json['createDate']}"); // Log để kiểm tra
  print("Raw author from JSON: ${json['author']}"); // Thêm log cho author
  return News(
    id: json['id'] as int?, // Ép kiểu và kiểm tra null
    content: json['content'] as String?,
    createDate: json['createDate'] != null ? DateTime.tryParse(json['createDate'] as String) : null,
    image: json['image'] as String?,
    lastModify: json['lastModify'] != null ? DateTime.tryParse(json['lastModify'] as String) : null,
    title: json['title'] as String?,
    view: json['view'] as int?,
    author: json['author'] as String? ?? 'unknown', // Gán giá trị mặc định nếu null
  );
}
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'create_date': createDate?.toIso8601String(),
      'image': image,
      'last_modify': lastModify?.toIso8601String(),
      'title': title,
      'view': view,
      'author': author,
    };
  }
}