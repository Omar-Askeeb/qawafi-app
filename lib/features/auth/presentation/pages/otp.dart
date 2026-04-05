import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/pages/my_app_page.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/go_to_subscription.dart';
import 'package:qawafi_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:qawafi_app/features/subscription/presentation/pages/subscription_management_page.dart';

import '../../../../core/common/widgets/background_image_scaffold.dart';
import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/button.dart';

class Otp extends StatefulWidget {
  static const String routeName = "/Otp";

  const Otp({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.password,
    this.isReset = false,
  });
  static route(
          {required String name,
          required String phoneNumber,
          required String passowrd,
          bool isReset = false}) =>
      MaterialPageRoute(
        builder: (context) => Otp(
          name: name,
          password: passowrd,
          phoneNumber: phoneNumber,
          isReset: isReset,
        ),
        settings: const RouteSettings(name: routeName),
      );

  final String name;
  final String phoneNumber;
  final String password;
  final bool isReset;

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 60; // 3 minutes in seconds
  bool _canResend = false;

  @override
  void initState() {
    print('DEBUG: Otp.initState for ${widget.phoneNumber}');
    super.initState();
    if (widget.phoneNumber.contains('944580235')) {
      print('DEBUG: Auto-filling OTP for test account');
      for (int i = 0; i < 4; i++) {
        _controllers[i].text = (i + 1).toString();
      }
    }
    startTimer();
  }

  void startTimer() {
    _canResend = false;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _canResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void resendOtp(
      {required String phoneNumber,
      required String password,
      required String name}) {
    context.read<AuthBloc>().add(AuthRequestOtp(
          phoneNumber: phoneNumber,
          password: password,
          name: name,
          isResend: true,
        ));
    setState(() {
      _start = 60;
      startTimer();
    });
    // Add your OTP resend logic here
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String getFieldsText() {
    String code = '';
    for (var i = 0; i < _controllers.length; i++) {
      code = code + _controllers[i].text.trim();
    }
    return code;
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'المصادقة الثنائية'),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
              if (state is AuthOtpSent) {
                // Navigator.push(context, Otp.route());
                showSnackBar(context, state.message);
              }
              if (state is AuthSuccess) {
                showSnackBar(context, 'تم تسجيل حساب بنجاح');
                // Navigator.push(context, HomePage.route());

                Navigator.pushAndRemoveUntil(
                  context,
                  MyAppPage.route(),
                  (route) => false,
                );

                if (RedirectSignupFlagSingleton().isRedirect) {
                  RedirectSignupFlagSingleton().isRedirect = false;
                  Navigator.push(
                    context,
                    SubscriptionManagementPage.route(),
                  );
                }
              }
              if (state is AuthResetPasswordTokenState) {
                Navigator.push(
                  context,
                  ResetPasswordPage.route(
                    phoneNumber: state.phoneNumber,
                    token: state.token,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }

              return Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('لقد أرسلنا رمز التحقق إلى الرقم'),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.phoneNumber,
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                    OTPInput(
                        controllers: _controllers, focusNodes: _focusNodes),
                    _canResend
                        ? GestureDetector(
                            onTap: () => resendOtp(
                              name: widget.name,
                              password: widget.password,
                              phoneNumber: widget.phoneNumber,
                            ),
                            child: const Text(
                              'إعادة إرسال الكود',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        : Text(
                            formatTime(_start),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      text: 'استمرار',
                      onPressed: () {
                        if (!widget.isReset &
                            formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignUp(
                                  phoneNumber: widget.phoneNumber,
                                  password: widget.password,
                                  name: widget.name,
                                  code: getFieldsText(),
                                ),
                              );
                        } else if (widget.isReset &
                            formKey.currentState!.validate()) {
                          // log('Reset Password');
                          context
                              .read<AuthBloc>()
                              .add(AuthGetResetPasswordToken(
                                phoneNumber: widget.phoneNumber,
                                otp: getFieldsText(),
                              ));
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OTPInput extends StatefulWidget {
  OTPInput({
    super.key,
    required List<TextEditingController> controllers,
    required List<FocusNode> focusNodes,
  })  : _controllers = controllers,
        _focusNodes = focusNodes;

  @override
  _OTPInputState createState() => _OTPInputState();

  final List<TextEditingController> _controllers;
  final List<FocusNode> _focusNodes;
}

class _OTPInputState extends State<OTPInput> {
  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      widget._focusNodes[index + 1].requestFocus();
      if (widget._controllers[index + 1].text.isNotEmpty)
        widget._controllers[index + 1].selection = TextSelection(
          baseOffset: 0,
          extentOffset: widget._controllers[index + 1].text.length,
        );
    } else if (value.isEmpty && index > 0) {
      widget._focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) {
              return SizedBox(
                width: 66,
                height: 80,
                child: TextFormField(
                  controller: widget._controllers[index],
                  focusNode: widget._focusNodes[index],
                  style: const TextStyle(
                      color: AppPallete.backgroundColor, fontSize: 18),
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  onTap: () {
                    widget._controllers[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: widget._controllers[index].text.length,
                    );
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: AppPallete.primaryColor),
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                  onChanged: (value) {
                    _onChanged(value, index);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
