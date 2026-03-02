import 'package:flutter/material.dart';
import 'package:qawafi_app/features/auth/presentation/widgets/auth_wrapper_button.dart';

import '../../../../core/common/pages/my_app_page.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/size_config.dart';
import '../../../webview/presentation/pages/auth_webview.dart';
import '../widgets/divider.dart';

class AuthWarpper extends StatefulWidget {
  static const String routeName = '/AuthWarpper';
  static route() => MaterialPageRoute(
        builder: (context) => const AuthWarpper(),
        settings: const RouteSettings(name: routeName),
      );
  const AuthWarpper({super.key});

  @override
  State<AuthWarpper> createState() => _AuthWarpperState();
}

class _AuthWarpperState extends State<AuthWarpper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.BACKGRPUND_SPLAH_2,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.65),
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.LOGO, height: 218),
                  AuthWarpperButton(
                    onPressed: () =>
                        Navigator.push(context, FlutterWebView.route()),
                    text: 'اشترك الأن',
                    color: Colors.black,
                  ),
                  // SizedBox(
                  //   height: getProportionateScreenHeight(20),
                  // ),
                  // AuthWarpperButton(
                  //   onPressed: () =>
                  //       Navigator.push(context, TabViewWrapper.route(1)),
                  //   text: 'حساب جديد',
                  //   color: Colors.black,
                  // ),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenHeight(327),
                    child: const Center(
                      child: AuthDivider(),
                    ),
                  ),
                  AuthWarpperButton(
                    onPressed: () => Navigator.push(context, MyAppPage.route()),
                    text: 'زائر',
                    textColor: AppPallete.secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
