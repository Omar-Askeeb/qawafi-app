import 'package:flutter/material.dart';
import 'package:qawafi_app/core/utils/size_config.dart';

import '../../../../core/theme/app_pallete.dart';

class CategoyContainer extends StatelessWidget {
  const CategoyContainer(
      {super.key,
      required this.imagePath,
      required this.text,
      this.width,
      required this.onPressed});

  final String imagePath;
  final String text;
  final double? width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 168,
        width: width != null
            ? getProportionateScreenWidth(width!)
            : SizeConfig.screenWidth! / 2 - 15,
        child: Stack(
          children: [
            SizedBox(
              width: width != null
                  ? getProportionateScreenWidth(width!)
                  : SizeConfig.screenWidth! / 2 - 15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // نصف القطر الدائري
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  height: 60,
                  // margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // نصف القطر الدائري

                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.20,
                        0.25,
                        0.27,
                        0.30,
                        0.39,
                        // 0.71,
                        1.0,
                      ],
                      colors: [
                        AppPallete.blackColor.withOpacity(0.09),
                        AppPallete.blackColor.withOpacity(0.12),
                        AppPallete.blackColor.withOpacity(0.2),
                        AppPallete.blackColor.withOpacity(0.4),
                        AppPallete.blackColor.withOpacity(0.51),
                        // AppPallete.blackColor.withOpacity(0.95),
                        AppPallete.blackColor.withOpacity(1.0),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
