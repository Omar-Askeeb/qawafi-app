import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  static double? topPadding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
    topPadding = _mediaQueryData!.padding.top;
    print('XXXXXXXXXXXX : $screenWidth $screenHeight');
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  // return (inputHeight / 1536.0) * screenHeight;

  return (inputHeight / 812) * screenHeight;
}

double getProportionateScreenHeightDesktop(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 812 is the layout height that designer use
  // return (inputHeight / 1536.0) * screenHeight;

  return (inputHeight / 812) * screenHeight;
  // return (inputHeight / 896.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  // return (inputWidth / 800.8) * screenWidth;

  return (inputWidth / 375.0) * screenWidth;
}

double getProportionateScreenWidthDesktop(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!;
  // 375 is the layout width that designer use
  // return (inputWidth / 800.8) * screenWidth;
  return (inputWidth / 1536.0) * screenWidth;

  // return (inputWidth / 414.0) * screenWidth;
}
