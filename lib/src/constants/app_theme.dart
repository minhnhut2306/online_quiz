import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    primaryColor: const Color.fromARGB(255, 219, 48, 34),
    scaffoldBackgroundColor: Color.fromARGB(255, 243, 241, 241),
    fontFamily: 'OpenSans',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      displayMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 86, 85, 85)),
      displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 86, 85, 85)),
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
      titleMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
      bodyLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      bodySmall: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      labelLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}
