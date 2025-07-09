import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:online_quiz/src/constants/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Online Quiz",
      routerDelegate: AppRoute.router.routerDelegate,
      routeInformationParser: AppRoute.router.routeInformationParser,
      routeInformationProvider: AppRoute.router.routeInformationProvider,
      builder: (context, child) {
        final statusBarHeight = MediaQuery.of(context).padding.top;
        print('Status bar height: $statusBarHeight'); // Kiểm tra chiều cao thanh trạng thái
        return SafeArea(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}