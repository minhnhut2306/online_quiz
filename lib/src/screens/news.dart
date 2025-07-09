import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:online_quiz/src/constants/models/newmodel.dart';
import 'package:online_quiz/src/constants/models/user.dart';
import 'package:online_quiz/src/constants/services/new_service.dart';
import 'package:online_quiz/src/constants/services/user_service.dart';
import 'package:online_quiz/src/widgets/pagedgrid.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>?>(
      future: NewsService().getNewsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
      
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có tin tức'));
        }

        List<News> newsList = snapshot.data!;

        return PagedGrid(
          items:
              newsList.map((newsItem) {
                final userId =
                    newsItem.author ?? 'unknown'; // Đảm bảo không null
                print(
                  'Mapping news item - title: ${newsItem.title}, userId: $userId',
                ); // Log để debug
                return {
                  "title": newsItem.title,
                  "description": newsItem.content,
                  "views": newsItem.view,
                  "date":
                      newsItem.lastModify != null
                          ? DateFormat(
                            'dd/MM/yyyy',
                          ).format(newsItem.lastModify!)
                          : 'N/A',
                  "userId": userId, // Sử dụng userId đã kiểm tra
                  "image": newsItem.image ?? '',
                };
              }).toList(),
          itemBuilder: (context, doc) {
            return FutureBuilder<User?>(
              future: UserService().getUserById(doc['userId'] ?? ''),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (userSnapshot.hasError || userSnapshot.data == null) {
                  print(
                    'Error fetching user or user not found: ${userSnapshot.error}',
                  );
                  return _buildNewsCard(
                    context,
                    doc,
                    'Unknown',
                  ); // Hiển thị "Unknown" nếu lỗi
                }

                String userName =
                    userSnapshot.data!.fullName ??
                    'Unknown'; // Lấy fullName từ User
                return _buildNewsCard(context, doc, userName);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildNewsCard(
    BuildContext context,
    Map<String, dynamic> doc,
    String userName,
  ) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('Detail', extra: doc);
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                doc['image'],
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
    );
  }
}
