import 'package:flutter/material.dart';
import 'package:qawafi_app/features/poem/domain/entites/poem.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/utils/size_config.dart';

class PoemBoxWidget extends StatelessWidget {
  const PoemBoxWidget({
    super.key,
    required this.poem,
  });
  final Poem poem;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenWidth(100),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the radius as needed
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black, // Set background color to black
              ),
              height: getProportionateScreenHeight(70),
              width: getProportionateScreenWidth(100),
              child: Image.asset(
                AppImages.logoMostStremed,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5,
                right: 5,
              ),
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.play_circle,
                  size: 18,
                  color: Colors
                      .white, // Ensure the icon is visible on black background
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(
                      0.7), // Black with opacity for the text background
                ),
                height: 20,
                width: double.infinity,
                child: Center(
                  child: Text(
                    poem.title,
                    style: const TextStyle(
                      fontSize: 12,
                      color:
                          Colors.white, // Set text color to white for contrast
                    ),
                  ),
                ),
              ),
            ),
            if (poem.isFree) ...{
              const Positioned(
                left: 5,
                top: 5,
                child: Text(
                  "مجاني",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Colors.white, // Ensure the "مجاني" text is also visible
                  ),
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
