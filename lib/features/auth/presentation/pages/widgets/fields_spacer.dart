import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_size.dart';

class FieldSpacer extends StatelessWidget {
  const FieldSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppSize.textFieldSpacing,
    );
  }
}
