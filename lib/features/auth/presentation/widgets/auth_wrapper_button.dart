import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/utils/size_config.dart';

class AuthWarpperButton extends StatelessWidget {
  const AuthWarpperButton({
    super.key,
    required this.text,
    this.color,
    this.textColor = Colors.white,
    required this.onPressed,
  });
  final String text;
  final Color? color;
  final Color? textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: getProportionateScreenWidth(200),
        height: getProportionateScreenHeight(56),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(50),
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
