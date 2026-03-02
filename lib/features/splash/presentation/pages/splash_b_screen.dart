import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/splash/presentation/bloc/splash_bloc.dart';

import '../../../../core/constants/app_images.dart';
import '../../../auth/presentation/warpper/auth_warpper.dart';

class SplashBScreen extends StatelessWidget {
  static const String routeName = '/SplashB';

  static route() => MaterialPageRoute(
        builder: (context) => const SplashBScreen(),
        settings: const RouteSettings(name: routeName),
      );
  const SplashBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.BACKGRPUND_SPLAH_B,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                AppImages.LOGO,
                height: 181,
              ),
            ),
          ),
          BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is SplashBDone) {
                Navigator.pushReplacement(context, AuthWarpper.route());
              }
            },
            child: BlackRectangleWidget(
                onPressed: () =>
                    context.read<SplashBloc>().add(SplashIsFirstTime())),
          ),
        ],
      ),
    );
  }
}

class BlackRectangleWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const BlackRectangleWidget({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 400, // Adjust the height as needed
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages
                    .BACKGRPUND_SPLAH_B_BLACK_REC, // Replace with your image asset
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent
                        .withOpacity(0.7), // Adjust opacity as needed
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'استمتع بتجربة\nالإستماع للقصائد.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPallete.secondaryColor,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'يتضمن التطبيق قصائد لأشهر الشعراء العرب بمختلف عصورهم.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: getProportionateScreenWidth(240.2),
                        height: getProportionateScreenHeight(56),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.orange,
                            backgroundColor: Colors.black, // foreground
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.orange),
                            ),
                          ),
                          onPressed: onPressed,
                          child: Text(
                            'الدخول',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
