import 'package:flutter/material.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';

import '../../constants/app_images.dart';

class QawafiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QawafiAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        scrolledUnderElevation: 0.0,
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(120);
}



// PreferredSize(
//           preferredSize: preferredSize,
//           child: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(),
//                 Text('تسجيل الدخول'),
//                 Spacer(),
//                 Image.asset(
//                   AppImages.LOGO, // replace with your image path
//                   height: 100.0, // control the height of the image
//                 ),
//               ],
//             ),
//             centerTitle: true,
//           ),
//         ),