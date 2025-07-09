import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;

  Map<String, dynamic>? userData; // This will hold user data from SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load data from SharedPreferences on init
  }

  // Function to load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    
    if (userDataString != null) {
      // Parse the data if it's available
      setState(() {
        userData = jsonDecode(userDataString); // Parse data from JSON string

        // Initialize controllers only when data is loaded
        _fullNameController = TextEditingController(text: userData?['full_name']);
        _emailController = TextEditingController(text: userData?['email']);
        _addressController = TextEditingController(text: userData?['address']);
        _phoneNumberController = TextEditingController(text: userData?['phone_number']);
      });
    }
  }

  // Function to update user data
  void _updateUser(Map<String, dynamic> userData) {
    // Update logic to handle the updated data
    setState(() {
      userData['full_name'] = _fullNameController.text;
      userData['email'] = _emailController.text;
      userData['address'] = _addressController.text;
      userData['phone_number'] = _phoneNumberController.text;
    });

    // You can send this updated data to API or save it again to SharedPreferences
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Thông tin đã được cập nhật')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      // Show loading indicator if user data is not loaded yet
      return Scaffold(
        appBar: AppBar(
          title: Text('Thông tin người dùng'),
          backgroundColor: Colors.blue,
        ),
        body: Center(child: CircularProgressIndicator()), // Loading state
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display user avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userData?['img'] ?? 'https://via.placeholder.com/150'),
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: 20),
            // Text fields for updating user data
            _buildTextField('Họ tên', _fullNameController),
            _buildTextField('Email', _emailController),
            _buildTextField('Địa chỉ', _addressController),
            _buildTextField('Số điện thoại', _phoneNumberController),
            SizedBox(height: 20),
            // Update button
            ElevatedButton(
              onPressed: () => _updateUser(userData!), // Update user data
              child: Text('Cập nhật thông tin'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
