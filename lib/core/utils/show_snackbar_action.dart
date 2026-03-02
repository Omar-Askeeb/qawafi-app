import 'package:flutter/material.dart';

void showSnackBarAction(
  BuildContext context,
  String content, {
  String buttonText = "موافق",
  required VoidCallback onPressed,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: buttonText,
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
}
