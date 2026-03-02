import '/../core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.whiteColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(18),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.transparentColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.transparentColor,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppPallete.backgroundColor,
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPallete.whiteColor,
      labelStyle: const TextStyle(color: AppPallete.backgroundColor),
      contentPadding: const EdgeInsets.all(15),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.primaryColor),
      errorBorder: _border(AppPallete.errorColor),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Helvetica',
        ),
  );

  static buttonBorder([Color color = AppPallete.borderColor]) => Border.all(
        color: color,
        width: 2,
      );
}
