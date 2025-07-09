import 'package:flutter/material.dart';
  import 'package:online_quiz/src/constants/shared_preferences_helper.dart';
import 'package:online_quiz/src/widgets/carousel_slider.dart';
import '../widgets/custom_header.dart';
import '../widgets/top3_ranking.dart';
import '../widgets/new_members.dart';
import '../widgets/subjects_grid.dart';
import '../widgets/resources_list.dart';
import '../widgets/weekly_news.dart';
import 'package:online_quiz/src/constants/services/result_service.dart';
import 'package:online_quiz/src/constants/models/resultmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> imgArr = [
    "assets/images/banner.png",
    "assets/images/banner-2.png",
  ];

  final List<Map<String, dynamic>> newMembers = [
    {"name": "admin test", "action": "trở thành thành viên của Website"},
    {"name": "user test", "action": "trở thành thành viên của Website"},
    {"name": "admin test", "action": "trở thành thành viên của Website"},
    {"name": "user test", "action": "trở thành thành viên của Website"},
    {"name": "admin test", "action": "trở thành thành viên của Website"},
    {"name": "user test", "action": "trở thành thành viên của Website"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomHeader(userDataFuture: SharedPreferencesHelper.loadUserData()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Load topUsers dynamically using FutureBuilder
                  FutureBuilder<List<Result>>(
                    future: ResultService().getTop10(), // Get top 10 results
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Có lỗi xảy ra: ${snapshot.error}'),
                        );
                      }

    
                      List<Result> topUsers = snapshot.data!;
                      return Column(
                        children: [
                          // Top3Ranking(topUsers: topUsers), // Pass topUsers here
                          // const SizedBox(height: 10),
                          WeeklyNews(),
                          const SizedBox(height: 10),
                          CarouselSlider(imagePaths: imgArr),
                          const SizedBox(height: 10),
                          SubjectsGrid(),
                          // NewMembers(newMembers: newMembers),
                          // const SizedBox(height: 10),
                          ResourcesList(),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
