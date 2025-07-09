import 'package:flutter/material.dart';

class CustomDialog {
  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Huỷ'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
            child: Text('Đồng ý'),
          ),
        ],
      ),
    );
  }
}
