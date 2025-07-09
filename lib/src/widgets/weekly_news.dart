import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_quiz/src/constants/models/newmodel.dart';
import 'package:online_quiz/src/constants/services/new_service.dart';
import 'package:go_router/go_router.dart'; // Make sure to import GoRouter

class WeeklyNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2196f3),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.newspaper, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                Text(
                  "TIN TỨC TRONG TUẦN",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          // Use FutureBuilder to fetch the news
          FutureBuilder<List<News>?>( 
            future: NewsService().getNewsList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Lỗi: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Không có tin tức'));
              }

              List<News> news = snapshot.data!;

              return SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: news.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final item = news[index];
                    return Container(
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  item.image ?? '',
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: Text(
                                      item.lastModify != null
                                          ? DateFormat('dd/MM/yyyy')
                                              .format(item.lastModify!)
                                          : 'N/A',
                                      style: const TextStyle(
                                        fontSize: 10.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            blurRadius: 3,
                                            offset: Offset(0, 1.2),
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                    color: Colors.blue[900],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.orange[400],
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    // Pass the entire News object or data as Map
                                    context.pushNamed(
                                      'Detail',
                                      extra: item.toJson(),
                                    );
                                  },
                                  child: const Text(
                                    "Xem thêm",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffba8430),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
