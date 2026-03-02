import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';

void showSuccessDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppPallete.whiteColor,
        // title: Text(title),
        content: Container(
          width: double.infinity,
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.blackColor,
                      fontFamily: 'Cairo'),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  content,
                  style: const TextStyle(
                      fontSize: 14.0, color: Colors.grey, fontFamily: 'Cairo'),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: getProportionateScreenWidth(185),
                child: AppButton(
                  text: 'موافق',
                  onPressed: () => Navigator.pop(context),
                  color: AppPallete.blackColor,
                  textColor: AppPallete.whiteColor,
                  opicity: 1,
                  borderColor: AppPallete.transparentColor,
                  height: 38.23,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        // actions: <Widget>[
        //   // TextButton(
        //   //   child: const Text('Cancel'),
        //   //   onPressed: () {
        //   //     Navigator.of(context).pop(); // Close the dialog
        //   //   },
        //   // ),
        //   TextButton(
        //     child: const Text('موافق'),
        //     onPressed: () {
        //       Navigator.of(context).pop(); // Close the dialog
        //     },
        //   ),
        // ],
      );
    },
  );
}

void showOkDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('موافق'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
