import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:online_quiz/src/constants/models/documentmodel.dart';
import 'package:online_quiz/src/constants/services/documentservice.dart';

class ResourcesList extends StatefulWidget {
  @override
  _ResourcesListState createState() => _ResourcesListState();
}

class _ResourcesListState extends State<ResourcesList> {
  late Future<List<Document>?> futureDocuments;

  @override
  void initState() {
    super.initState();
    futureDocuments =
        DocumentService().getDocumentsList(); // Gọi API để lấy tài liệu
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tài liệu tham khảo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[900],
                    fontFamily: 'Roboto',
                  ),
                ),
                const Icon(Icons.bookmark, color: Colors.blue, size: 24),
              ],
            ),
          ),
          FutureBuilder<List<Document>?>(
            future: futureDocuments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Không có tài liệu nào'));
              }

              List<Document> documents = snapshot.data!;

              // Shuffle danh sách tài liệu và lấy 4 tài liệu ngẫu nhiên
              documents.shuffle();
              documents = documents.take(4).toList();

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          documents[index].avatar ?? "",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.description, size: 50),
                        ),
                      ),
                      title: Text(
                        documents[index].title ?? 'Không có tiêu đề',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        "Ngày tạo: ${documents[index].createDate != null ? DateFormat('dd/MM/yyyy').format(documents[index].createDate! as DateTime) : 'N/A'}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      onTap: () {
                        // Navigate to DetailScreen with the selected document's data
                        context.pushNamed(
                          'Detail',
                          extra: {
                            'title': documents[index].title,
                            'image': documents[index].avatar,
                            'description': documents[index].content,
                            'date':
                                documents[index].createDate != null
                                    ? DateFormat('dd/MM/yyyy').format(
                                      documents[index].createDate! as DateTime,
                                    )
                                    : 'N/A',
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
