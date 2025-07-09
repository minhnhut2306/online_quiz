import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  final bool showDescription;
  const DetailScreen({Key? key, this.data, this.showDescription = true})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? item =
        data ??
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?);

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chi tiết')),
        body: const Center(child: Text("Không có dữ liệu")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          item['title'] ?? '',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item['image'] ?? '',
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (c, e, s) => Container(
                      height: 240,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 80),
                    ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              item['title'] ?? '',
              style: GoogleFonts.roboto(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${item['views'] ?? ''} lượt xem | ${item['date'] ?? ''}',
              style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[700]),
            ),
            if (showDescription &&
                ((item['description']?.isNotEmpty ?? false) ||
                    (item['content']?.isNotEmpty ?? false))) ...[
              const SizedBox(height: 28),
              Text(
                item['description']?.isNotEmpty ?? false
                    ? item['description']
                    : item['content'] ??
                        'Không có mô tả', // If description is empty, fallback to content
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
              ),
            ] else if ((item['description'] == null ||
                    item['description']!.isEmpty) &&
                (item['content'] == null || item['content']!.isEmpty)) ...[
              const SizedBox(height: 28),
              Text(
                'Không có mô tả', // Fallback message when both description and content are empty
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
