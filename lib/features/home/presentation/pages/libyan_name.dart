import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/constants/app_images.dart';

class LibyanNamePlaceholder extends StatelessWidget {
   LibyanNamePlaceholder({super.key, required this.title});
  static const String routeName = '/LibyanNamePlaceholder';
  static route(String title) => MaterialPageRoute(
        builder: (context) => LibyanNamePlaceholder(title: title),
        settings: const RouteSettings(name: routeName),
      );
  final String title;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(
          title: title,
        ),
        body: Container(
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              AppImages.LOGO,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "قريباً ...",
              style: TextStyle(fontSize: 24),
            )
          ]),
        ),
      ),
    );
  }
}
