import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../core/utils/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppPallete.secondaryColor,
    this.textColor,
    this.height = 60,
    this.borderColor,
    this.opicity = 0.4,
    this.fontFamily,
  });
  final String text;
  final Color color;
  final Color? textColor;
  final VoidCallback onPressed;
  final double height;
  final Color? borderColor;
  final double opicity;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getProportionateScreenHeight(height),
        decoration: BoxDecoration(
          color: color.withOpacity(opicity),
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(30),
          ),
          border: borderColor != null
              ? AppTheme.buttonBorder(borderColor!)
              : AppTheme.buttonBorder(),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontFamily: fontFamily,
              fontSize: getProportionateScreenWidth(16),
            ),
          ),
        ),
      ),
    );
  }
}
