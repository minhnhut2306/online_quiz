import 'package:flutter/material.dart';

class NewMembers extends StatelessWidget {
  final List<Map<String, dynamic>> newMembers;

  const NewMembers({required this.newMembers, super.key});

  @override
  Widget build(BuildContext context) {
    final int displayCount = newMembers.length > 4 ? 4 : newMembers.length;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Giúp co lại gọn, không thừa trắng
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header ...
          // --- giữ nguyên phần header ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[100]!, Colors.blue[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[800],
                      radius: 16,
                      child: Icon(Icons.group_add, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Thành viên mới",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.blue[900],
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_upward, size: 15, color: Colors.white),
                          Text(
                            " ${newMembers.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "tuần qua",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Danh sách thành viên (giới hạn 4 người)
          ...List.generate(displayCount, (index) {
            final member = newMembers[index];
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue[100],
                    backgroundImage: member["avatar"] != null && member["avatar"].toString().isNotEmpty
                        ? NetworkImage(member["avatar"])
                        : null,
                    child: member["avatar"] == null || member["avatar"].toString().isEmpty
                        ? Icon(Icons.person, color: Colors.blue[800], size: 24)
                        : null,
                  ),
                  title: Text(
                    member["name"] ?? "Chưa rõ tên",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    member["action"] ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(Icons.waving_hand_rounded, color: Colors.orange[700], size: 22),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  shape: index == displayCount - 1
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)))
                      : null,
                ),
                if (index != displayCount - 1)
                  Divider(height: 0, thickness: 0.6, color: Colors.grey[200]),
              ],
            );
          }),
        ],
      ),
    );
  }
}