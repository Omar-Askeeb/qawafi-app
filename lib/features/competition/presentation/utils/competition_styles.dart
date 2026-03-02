import 'package:flutter/material.dart';
import '../../../../core/theme/app_pallete.dart';

class CompetitionStyles {
  static const TextStyle headerStyle = TextStyle(
    fontFamily: 'ReemKufi',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppPallete.secondaryColor,
  );

  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    color: Colors.white70,
  );

  static const TextStyle countdownStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 12,
    color: AppPallete.secondaryColor,
  );

  static const Color openStatusColor = Colors.green;
  static const Color closedStatusColor = Colors.red;
}
