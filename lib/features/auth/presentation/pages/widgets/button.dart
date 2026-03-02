import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../core/utils/size_config.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppPallete.secondaryColor,
    this.textColor,
  });
  final String text;
  final Color color;
  final Color? textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getProportionateScreenHeight(60),
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(30),
          ),
          border: AppTheme.buttonBorder(),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
        ),
      ),
    );
  }
}
