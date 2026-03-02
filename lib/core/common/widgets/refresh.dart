import 'package:flutter/material.dart';
import 'package:qawafi_app/core/constants/app_images.dart';

class Refresh extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;
  final double height ;
  Refresh({required this.message, required this.onRefresh,this.height = 150});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الشعار
          Image.asset(
            AppImages.LOGO,
            height: height,
          ),
          SizedBox(height: 20), // المسافة بين الشعار والزر

          // رسالة عدم وجود اتصال بالإنترنت
          Text(
            '$message',
            style: TextStyle(
              fontSize: 18, // حجم الخط
              color: Colors.white, // لون النص
            ),
          ),
          SizedBox(height: 20), // المسافة بين النص والزر

          // زر "تحديث"
          Container(
            width: 200, // عرض الزر
            child: ElevatedButton(
              onPressed: onRefresh,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromRGBO(76, 64, 40, 1), // لون النص
              ),
              child: Text(
                'تحديث',
                style: TextStyle(fontSize: 18),
              ), // نص الزر
            ),
          ),
        ],
      ),
    );
  }
}
