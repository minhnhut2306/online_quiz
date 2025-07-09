import 'package:flutter/material.dart';
import 'package:online_quiz/src/constants/models/exammodel.dart';
import 'package:online_quiz/src/constants/models/resultmodel.dart';
import 'package:online_quiz/src/constants/models/user.dart';
import 'package:online_quiz/src/constants/services/exam_service.dart';
import 'package:online_quiz/src/constants/services/result_service.dart';
import 'package:online_quiz/src/constants/services/user_service.dart';
import 'package:online_quiz/src/screens/ranking_screen.dart';


class Top3Ranking extends StatelessWidget {
  final List<Result> topUsers;

  Top3Ranking({required this.topUsers});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Column(
        children: [
          // Header with "Top 3 Ranking"
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top 3 Bảng Xếp Hạng",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue[900],
                    fontFamily: 'Roboto',
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 20,
                  ),
                  onPressed: () {
                    List<Map<String, dynamic>> usersMap = topUsers.map((user) {
                      return {
                        'username': user.username,
                        'mark': user.mark,
                        'idExam': user.idExam,
                      };
                    }).toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RankingScreen(topUsers: usersMap),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // List of the top  fabs3 users
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: topUsers.length > 3 ? 3 : topUsers.length, // Show only top 3
            itemBuilder: (context, index) {
              final user = topUsers[index];

              return FutureBuilder<User?>(
                future: UserService().getUserById(user.username ?? ''),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (userSnapshot.hasError) {
                    print("User Error: ${userSnapshot.error}");
                    return Center(child: Text('Error: ${userSnapshot.error}'));
                  }

                  final userData = userSnapshot.data;

                  if (userData == null) {
                    return const Center(child: Text('Không có dữ liệu người dùng.'));
                  }

                  return FutureBuilder<Exam?>(
                    future: ExamService().getByexamId(user.idExam),
                    builder: (context, examSnapshot) {
                      if (examSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (examSnapshot.hasError) {
                        print("Exam Error: ${examSnapshot.error}");
                        return Center(child: Text('Error: ${examSnapshot.error}'));
                      }

                      final examData = examSnapshot.data;

                      if (examData == null) {
                        return const Center(child: Text('Không có dữ liệu bài thi.'));
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: userData.img.isNotEmpty
                                  ? NetworkImage(userData.img)
                                  : const AssetImage('assets/default_avatar.png') as ImageProvider,
                              backgroundColor: userData.img.isEmpty
                                  ? (index == 0 ? Colors.amber : index == 1 ? Colors.grey : Colors.brown)
                                  : Colors.transparent,
                              child: userData.img.isEmpty
                                  ? Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.fullName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    "${examData.nameExam} - Thời gian: ${examData.time} phút",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${user.mark} điểm",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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