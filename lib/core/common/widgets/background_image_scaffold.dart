import 'package:flutter/material.dart';

import '../../constants/app_images.dart';

class ScaffoldWithBackgroundImage extends StatelessWidget {
  const ScaffoldWithBackgroundImage({
    super.key,
    required this.scaffod,
  });
  final Scaffold scaffod;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppImages.BACKGRPUND_SPLAH,
            fit: BoxFit.cover,
          ),
        ),
        scaffod
      ],
    );
    // return Scaffold(
    //   appBar: appBar,
    //   backgroundColor: Colors.black,
    //   body: Stack(
    //     children: [
    //       Positioned.fill(
    //         child: Image.asset(
    //           AppImages.BACKGRPUND_SPLAH,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Container(
    //         child: body,
    //       ),
    //     ],
    //   ),
    // );
  }
}
