import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_pallete.dart';

class SubscriptionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SubscriptionAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppPallete.blackColor.withOpacity(0.6),
              image: const DecorationImage(
                image: AssetImage(AppImages.appBackgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppPallete.blackColor.withOpacity(0.6),
            ),
          ),
          AppBar(
            title: Text(
              title,
              style: const TextStyle(color: AppPallete.secondaryColor),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Image.asset(
                  AppImages.LOGO,
                  height: 60,
                ),
              )
            ],
            centerTitle: true,
            toolbarHeight: 120, // Adjust the height as needed

            // actions: ,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(120);
}
