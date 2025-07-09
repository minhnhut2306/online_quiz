import 'package:flutter/material.dart';

class ScreenSizeHelper {
  final BuildContext context;

  ScreenSizeHelper(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  double percentWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;
}
