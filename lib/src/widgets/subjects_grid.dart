import 'package:flutter/material.dart';
import 'package:online_quiz/src/constants/models/subjectmodel.dart';
import 'package:online_quiz/src/constants/services/subjectservice.dart';

class SubjectsGrid extends StatelessWidget {
  const SubjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subject>>(
      future: SubjectService().getAllSubjects(),
      builder: (context, snapshot) {
        // Hiển thị khi đang tải
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Nếu có lỗi
        if (snapshot.hasError) {
          return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
        }

        // Nếu không có dữ liệu
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('Không có môn học hoặc dữ liệu trả về null'); // Log khi không có dữ liệu
          return const Center(child: Text('Không có môn học'));
        }

        // Khi có dữ liệu
        List<Subject> subjects = snapshot.data!;
        
        // Log dữ liệu trả về từ API
        print('Danh sách môn học: $subjects');

        return Padding(
          padding: EdgeInsets.zero,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 4,
              childAspectRatio: 1.1,
            ),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return _buildSubjectCard(context, subjects[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Subject subject) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            child: Container(
              height: 80,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Image.network(
                subject.image ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error_outline),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              subject.name ?? "Unknown",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
