import 'package:flutter/material.dart';

Widget buildHeader(String title) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 24),
    ),
  );
}

Widget buildTextField(TextEditingController controller, String label,
    {bool obscureText = false, TextInputType? keyboardType, String? Function(String?)? validator}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: validator,
    ),
  );
}

Widget buildSubmitButton(String text, Color color, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      minimumSize: Size(double.infinity, 50),
    ),
  );
}

Widget buildRememberMe(bool value, Function(bool?) onChanged) {
  return Row(
    children: [
      Checkbox(value: value, onChanged: onChanged),
      Text('Remember me'),
    ],
  );
}