import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';

import '../../features/auth/presentation/warpper/auth_warpper.dart';
import 'navigator_key.dart';

Future<bool> onRefreshTokenExpired(LocalStorage localStorage) async {
  try {
    await localStorage.storeAccessToken('');
    await localStorage.storeRefreshToken('');
    await localStorage.storeMySubscription('');
    await localStorage.storeUser("");
    await localStorage.storeUserData("");

    navigatorKey.currentState!
        .pushAndRemoveUntil(AuthWarpper.route(), (route) => false);
    return true;
  } on Exception catch (e) {
    log(e.toString());
    return false;
  }
}

Future<void> handleTokenExpiration(LocalStorage localStorage) async {
  final userChoice = await showDialog<bool>(
    context: navigatorKey.currentContext!,
    barrierDismissible:
        false, // Prevent dismissing the dialog by tapping outside
    builder: (context) {
      return AlertDialog(
        title: Text('إنتهت الجلسة'),
        content: Text('الجلسة الخاصة بك انتهت الرجاء تسجيل الدخول مرة اخرى'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Sign In
            },
            child: Text('موافق'),
          ),
        ],
      );
    },
  );

  if (userChoice == true) {
    // If user chooses to sign in, execute the token expiration flow
    await onRefreshTokenExpired(localStorage);
  } else {
    log('User chose to stay on the page.');
  }
}
