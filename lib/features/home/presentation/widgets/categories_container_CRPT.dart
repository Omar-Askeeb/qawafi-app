import 'package:flutter/material.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';

class CategoyContainerCRPT extends StatelessWidget {
  const CategoyContainerCRPT(
      {super.key,
      required this.imagePath,
      required this.text,
      this.width = 168,
      required this.onPressed});

  final String imagePath;
  final String text;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 175,
        width: getProportionateScreenWidth(width),
        child: Stack(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(width),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // نصف القطر الدائري
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.crptLogo,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppPallete.blackColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 0,
                                  right: 5,
                                ),
                                child: Text(
                                  text,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 0, right: 8),
                                child: const Text(
                                  'استمتع بكل لحظة انتظار مع أفضل النغمات',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                height: 40,
                width: 150,
                child: AppButton(
                  text: 'أبدأ التجربة الآن',
                  onPressed: onPressed,
                  borderColor: AppPallete.transparentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}