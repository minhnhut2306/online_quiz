import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_quiz/src/constants/app_color.dart';
import 'package:online_quiz/src/controller/dashboard_controller.dart';
import 'package:online_quiz/src/screens/Home.dart';
import 'package:online_quiz/src/screens/news.dart';
import 'package:online_quiz/src/screens/createaquiz.dart';
import 'package:online_quiz/src/screens/document.dart';
import 'package:online_quiz/src/screens/profile.dart';
import 'package:online_quiz/src/widgets/custom_dialog.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final controller = Get.put(DashboardController());

  final List<_NavItem> _navItems = const [
    _NavItem(iconPath: 'assets/icons/home.svg', label: 'Trang chủ'),
    _NavItem(iconPath: 'assets/icons/create.svg', label: 'Tạo đề'),
    _NavItem(iconPath: 'assets/icons/document.svg', label: 'Tài liệu'),
    _NavItem(iconPath: 'assets/icons/document.svg', label: 'Tin tức'),
    _NavItem(iconPath: 'assets/icons/nguoi.svg', label: 'Cá nhân'),
  ];

  final List<Widget> _pages = [
    HomeScreen(),
    CreateQuizScreen(),
    DocumentScreen(),
    NewsScreen(),
    ProfileScreen(),
  ];

  Future<void> _onBackPressed(BuildContext context) async {
    CustomDialog.showCustomDialog(
      context: context,
      title: 'Đóng ứng dụng',
      content: 'Ứng dụng sẽ được đóng lại ?',
      onPressed: () {
        Get.back();
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: AppColor.subMain,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Obx(() => _pages[controller.currentIndex.value]),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF6F9FB),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 14,
                  offset: Offset(0, -1),
                ),
              ],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  final isSelected = controller.currentIndex.value == index;
                  final navItem = _navItems[index];
                  return Expanded(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColor.fourthMain.withOpacity(0.16)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(13),
                          onTap: () => controller.changePage(index),
                          child: SizedBox(
                            height: 54,
                            child: Center(
                              // <-- Căn giữa hoàn toàn
                              child: Text(
                                navItem.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                      isSelected
                                          ? AppColor.fourthMain
                                          : AppColor.grey,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String iconPath;
  final String label;

  const _NavItem({required this.iconPath, required this.label});
}
