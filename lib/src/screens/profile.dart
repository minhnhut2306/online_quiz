import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_quiz/src/constants/app_color.dart';
import 'package:online_quiz/src/controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.subMain,
      body: Column(
        children: [
          // User profile section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.fourthMain.withOpacity(0.9),
                  AppColor.fivethMain,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // User avatar
                GestureDetector(
                  onTap: () {
                    controller.getImagePicker(2).then((value) {
                      if (value != null) {
                        controller.image.value = value;
                      }
                    });
                  },
                  child: Obx(() {
                    Widget avatarWidget;
                    if (controller.image.value.path.isNotEmpty) {
                      avatarWidget = Image.file(
                        controller.image.value,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                          Icons.person_outline,
                          size: 60,
                          color: AppColor.fourthMain,
                        ),
                      );
                    } else if (controller.img.value.isNotEmpty) {
                      avatarWidget = Image.network(
                        controller.img.value,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                          Icons.person_outline,
                          size: 60,
                          color: AppColor.fourthMain,
                        ),
                      );
                    } else {
                      avatarWidget = Icon(
                        Icons.person_outline,
                        size: 60,
                        color: AppColor.fourthMain,
                      );
                    }

                    return Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.fourthMain,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(child: avatarWidget),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          return Text(
                            controller.fullname.value.isNotEmpty
                                ? controller.fullname.value
                                : 'Người dùng',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          // Remaining content section
          Expanded(
            child: Container(
              color: AppColor.fivethMain,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Thông tin cá nhân',
                    onTap: () => controller.personal(context),
                  ),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.people_alt_outlined,
                    title: 'Về chúng tôi',
                    onTap: () => controller.family(context),
                  ),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.calendar_today_outlined,
                    title: 'Điều khoản',
                    onTap: () => controller.appointmentHistory(context),
                  ),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    icon: Icons.logout_outlined,
                    title: 'Đăng xuất',
                    onTap: () => controller.logout(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Menu item widget builder
  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppColor.fourthMain),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
