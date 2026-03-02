import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

void ringsDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text(
          "تنبيه",
          style: TextStyle(
            //  fontSize: 16.0,
            color: AppPallete.libyanTitlesCardsTitleColor,
          ),
        )),
        content: Text(
            "هذه الخدمة لمشتركين شبكة المدار فقط! \nسعر الإشتراك لا يشمل هذه الخدمة"),
        actions: [
          TextButton(
            child: Center(
                child: Text(
              "متابعة",
              style: TextStyle(
                fontSize: 20,
                color: AppPallete.libyanTitlesCardsTitleColor,
              ),
            )),
            onPressed: () {
              Navigator.of(context).pop(); // لإغلاق النافذة
            },
          ),
        ],
      );
    },
  );
}
