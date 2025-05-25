import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleWidth;
  static late double scaleHeight;

  static void init(BuildContext context, {double baseWidth = 375.0, double baseHeight = 812.0}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    scaleWidth = screenWidth / baseWidth;
    scaleHeight = screenHeight / baseHeight;
  }
}

extension AdaptiveExtensions on double {
  double get adptW => this * SizeConfig.scaleWidth;
  double get adptH => this * SizeConfig.scaleHeight;
  double get adptSP => this * ((SizeConfig.scaleWidth + SizeConfig.scaleHeight) / 2) * 0.9;
}
