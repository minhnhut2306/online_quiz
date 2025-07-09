import 'package:flutter/material.dart';
import 'package:online_quiz/src/constants/models/user.dart';
import 'package:online_quiz/src/constants/shared_preferences_helper.dart';

class CustomHeader extends StatelessWidget {
  final Future<Map<String, dynamic>?> userDataFuture;

  const CustomHeader({Key? key, required this.userDataFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: userDataFuture,  // Load user data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while data is being fetched
          return SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(child: Text('Có lỗi xảy ra')),
          );
        }

        if (!snapshot.hasData) {
          return SliverAppBar(
            expandedHeight: 90,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(child: Text('Chưa đăng nhập')),
          );
        }

        final user = snapshot.data;

        return SliverAppBar(
          expandedHeight: 90,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundImage: user!['img'] != null && user['img'].isNotEmpty
                      ? NetworkImage(user['img'])
                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Xin chào,', style: TextStyle(color: Colors.white70, fontSize: 16, fontFamily: 'Roboto')),
                      Text(
                        user['fullName'] ?? 'Unknown User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
