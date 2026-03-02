import 'package:flutter/material.dart';

class AccountOpation {
  final String title;
  final String iconPath;
  final VoidCallback action;

  AccountOpation({
    required this.title,
    required this.iconPath,
    required this.action,
  });
}
