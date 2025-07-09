import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:online_quiz/src/widgets/pagedgrid.dart';
import 'package:online_quiz/src/constants/services/documentservice.dart';
import 'package:online_quiz/src/constants/models/documentmodel.dart';

class DocumentScreen extends StatelessWidget {
  late Future<List<Document>?> futureDocuments;

  @override
  Widget build(BuildContext context) {
    // Fetch documents list via API
    futureDocuments = DocumentService().getDocumentsList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Tài liệu', style: GoogleFonts.roboto()),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Document>?>(
        future: futureDocuments,
        builder: (context, snapshot) {
          // Show CircularProgressIndicator while loading data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Show error message if there's an issue fetching data
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          // Check if there's no data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có tài liệu nào'));
          }

          List<Document> documents = snapshot.data!;

          return PagedGrid(
            items:
                documents
                    .map(
                      (doc) => {
                        'title': doc.title,
                        'views': doc.view,
                          "date":
                      doc.createDate != null
                          ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(doc.createDate!)
                          : 'N/A',
                        'user': doc.userId,
                        'image': doc.avatar,
                        'content': doc.content,
                      },
                    )
                    .toList(),
            itemBuilder:
                (context, doc) => GestureDetector(
                  onTap: () {
                    // Navigate to DetailScreen with the selected document's data
                    context.pushNamed(
                      'Detail',
                      extra: doc, // Pass document data to the Detail screen
                    );
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            doc['image'] ?? "",
                            fit: BoxFit.cover,
                            errorBuilder:
                                (c, e, s) => Container(
                                  color: Colors.grey[200],
                                  child: Icon(Icons.image, size: 100),
                                ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15),
                              ),
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, 0.7],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  doc['title'],
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "${doc['views']} lượt xem | ${doc['date']}",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
