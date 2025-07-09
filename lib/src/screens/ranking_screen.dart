import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> topUsers;

  RankingScreen({required this.topUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bảng Xếp Hạng Top 10",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 4,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: topUsers.length,
          itemBuilder: (context, index) {
            final user = topUsers[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: user["image"] != null && user["image"].isNotEmpty
                      ? NetworkImage(user["image"])
                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                  backgroundColor: user["image"] == null || user["image"].isEmpty
                      ? (index == 0 ? Colors.amber : index == 1 ? Colors.grey : index == 2 ? Colors.brown : Colors.grey[300])
                      : Colors.transparent,
                  child: user["image"] == null || user["image"].isEmpty
                      ? Text("${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                      : null,
                ),
                title: Text(
                  user["name"] ?? "User name", // Make sure there's a fallback for user["name"]
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                subtitle: Text(
                  "${user["class"] ?? "Class"} - ${user["time"] ?? "00:00"}", // Default values in case some fields are null
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                trailing: Text(
                  "${user["score"] ?? 0} điểm", // Default value in case score is missing
                  style: TextStyle(fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
