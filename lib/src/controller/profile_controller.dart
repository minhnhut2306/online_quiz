import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:online_quiz/src/constants/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var fullname = ''.obs;
  var img = ''.obs; // Image URL (from network)
  var image = Rx<File>(File('')); // Local image file

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadUserData(); // Load user data from shared preferences
  }

  // Select image from gallery or camera
  Future<File?> getImagePicker(int type) async {
    XFile? pickedFile;
    if (type == 1) {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Load user data from shared preferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      // Parse the stored data
      Map<String, dynamic> data = jsonDecode(userData);
      fullname.value = data['fullName'] ?? '';
      img.value = data['img'] ?? ''; // Assuming img is a URL
    }
  }

  // Save user data to shared preferences
  static Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userData = jsonEncode({
      'fullName': user.fullName,
      'img': user.img,
    });

    await prefs.setString('user_data', userData); // Save data to shared preferences
  }

  // Navigate to different pages
  void personal(BuildContext context) {
    context.pushNamed('UserDetail');
  }

  void family(BuildContext context) {
    context.pushNamed('AboutUs');
  }

  void appointmentHistory(BuildContext context) {
    context.pushNamed('TermsOfService');
  }

  // Logout functionality
  void logout(BuildContext context) {
    context.pushNamed('Login');
    Get.snackbar(
      'Đăng xuất',
      'Bạn đã đăng xuất thành công',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
    
    // Remove user data and token from shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user_data');
      prefs.remove('token');
    });
  }
}
