import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppPallete.secondaryColor,
      endIndent: 2,
    );
  }
}
