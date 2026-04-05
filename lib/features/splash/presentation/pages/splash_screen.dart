import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/pages/my_app_page.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/enums/user_state.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/features/auth/presentation/warpper/auth_warpper.dart';
import 'package:qawafi_app/features/customer/domain/usecases/my_subscription.dart';
import 'package:qawafi_app/init_dependencies.dart';

import '../../../../core/common/widgets/background_image_scaffold.dart';
import '../bloc/splash_bloc.dart';
import 'splash_b_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() => Navigator.pushReplacement(context, AuthWarpper.route());

  _startDelay(bool isFirstTime) {
    _timer = Timer(
        const Duration(seconds: 3),
        () => isFirstTime
            ? Navigator.pushReplacement(context, SplashBScreen.route())
            : _goNext());
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3),
        () => context.read<SplashBloc>().add(SplashCheck()));
  }

  Future<void> _init(String id) async {
    // Assuming your use case returns a Future
    final result =
        await serviceLocator<MySubscription>().call(StringParam(string: id));
    result.fold((failure) => print('Error: $failure'),
        (success) => print('Success: $success'));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SplashCheckFirstTime) {
              switch (state.userState) {
                case UserState.FirstTime:
                  Navigator.pushReplacement(context, SplashBScreen.route());
                  context.read<SplashBloc>().add(SplashIsFirstTime());
                  break;
                case UserState.Guest:
                  Navigator.pushReplacement(context, AuthWarpper.route());
                  break;
                case UserState.Logged:
                  Navigator.pushReplacement(context, MyAppPage.route());
                  _init((context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id);
                  break;
                default:
              }
              // if (state. == true) {
              //   context.read<SplashBloc>().add(SplashIsFirstTime());
              // }
              // if (state.isFirst) {
              //   Navigator.pushReplacement(context, SplashBScreen.route());
              // } else {
              //   _startDelay();
              // }
              // _startDelay(state.isFirst);
            }
          },
          child: Center(
            child: Image.asset(AppImages.LOGO),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Stack(
    //     children: [
    //       Positioned.fill(
    //         child: Image.asset(
    //           AppImages.BACKGRPUND_SPLAH,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Center(
    //         child: Image.asset('assets/images/logo.png'),
    //       ),
    //     ],
    //   ),
    //   // body: GradientBackground(),
    //   // body: Stack(
    //   //   children: <Widget>[
    //   //     Container(
    //   //       decoration: BoxDecoration(
    //   //         gradient: LinearGradient(
    //   //           begin: Alignment.topLeft,
    //   //           end: Alignment.bottomRight,
    //   //           colors: [Color(0xFFEAC578), Colors.black45],
    //   //         ),
    //   //       ),
    //   //     ),
    //   //     Container(
    //   //       decoration: BoxDecoration(
    //   //         gradient: RadialGradient(
    //   //           center: Alignment.center,
    //   //           radius: 0.5,
    //   //           colors: [Colors.transparent, Colors.black45],
    //   //         ),
    //   //       ),
    //   //     ),
    //   // Center(
    //   //   child: Image.asset('assets/images/logo.png'),
    //   // ),
    //   //   ],
    //   // ),
    // );
  }
}

class GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Black background
        // Container(
        //   color: Colors.black,
        // ),
        // // Top left gradient circle
        // Positioned(
        //   top: -20,
        //   right: -150,
        //   child: Container(
        //     width: 400,
        //     height: 350,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       gradient: RadialGradient(
        //         colors: [
        //           const Color(0xFFEAC578)
        //               .withOpacity(0.1), // Gradient color with opacity
        //           Colors.transparent,
        //         ],
        //         radius: 0.5,
        //       ),
        //     ),
        //   ),
        // ),
        // // Bottom left gradient circle
        // Positioned(
        //   bottom: -100,
        //   left: -100,
        //   child: Container(
        //     width: 400,
        //     height: 400,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       gradient: RadialGradient(
        //         colors: [
        //           const Color(0xFFEAC578)
        //               .withOpacity(0.1), // Gradient color with opacity
        //           Colors.transparent,
        //         ],
        //         radius: 1,
        //       ),
        //     ),
        //   ),
        // ),
        // // Optional: blur effect
        // Positioned.fill(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        //     child: Container(
        //       color: Colors.black
        //           .withOpacity(0.1), // Make it transparent to only apply blur
        //     ),
        //   ),
        // ),
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset('assets/images/background_splash.png',
              fit: BoxFit.fill),
        ),
        // Content
        Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ],
    );
  }
}
