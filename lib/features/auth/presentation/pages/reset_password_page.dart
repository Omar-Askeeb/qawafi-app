import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/auth/presentation/pages/tab_view_wrapper.dart';
import 'package:qawafi_app/features/auth/presentation/warpper/auth_warpper.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/validation/input_validation.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/auth_field_label.dart';
import 'widgets/button.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String routeName = '/ResetPassword';
  const ResetPasswordPage({
    super.key,
    required this.token,
    required this.phoneNumber,
  });
  static route({
    required String token,
    required String phoneNumber,
  }) =>
      MaterialPageRoute(
        builder: (context) =>
            ResetPasswordPage(phoneNumber: phoneNumber, token: token),
        settings: const RouteSettings(name: routeName),
      );

  final String token;
  final String phoneNumber;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextStyle _header =
      const TextStyle(fontSize: 20, color: AppPallete.whiteColor);

  final TextStyle _subTitle =
      TextStyle(fontSize: 14, color: AppPallete.whiteColor.withOpacity(0.8));

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confiemPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: QawafiAppBar(title: widget.phoneNumber),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is AuthFailure) {
                log('AuthFailure ...');

                showSnackBar(context, state.message);
              }
              if (state is AuthResuthPasswordSuccess) {
                showSnackBar(context, state.message);
                Navigator.pushAndRemoveUntil(
                  context,
                  TabViewWrapper.route(0),
                  (route) {
                    log('Route ...');

                    log(route.toString());
                    log(route.settings.name.toString());
                    return route.settings.name == AuthWarpper.routeName;
                  },
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'إعادة تعيين كلمة المرور',
                      style: _header,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'قم بتعيين كلمة المرور الجديدة لحسابك حتى تتمكن من تسجيل الدخول والوصول إلى جميع الميزات.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _subTitle,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AuthFieldLabel(
                      "كلمة المرور الجديدة",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: InputValidation.requiredPasswordValidation(),
                      style: const TextStyle(
                        color: AppPallete.backgroundColor,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: AppIcon.lock,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AuthFieldLabel(
                      "إعادة إدخال كلمة المرور",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _confiemPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: _validateConfirmPassword,
                      style: const TextStyle(
                        color: AppPallete.backgroundColor,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: AppIcon.lock,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          log('Sucess');
                          context.read<AuthBloc>().add(
                                ResetPasswordEvent(
                                  phoneNumber: widget.phoneNumber,
                                  password: _password.text.trim(),
                                  token: widget.token,
                                ),
                              );
                        }
                      },
                      text: "تغيير كلمة المرور",
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور';
    }
    if (value.trim() != _password.text.trim()) {
      return 'كلمة المرور لا تتطابق';
    }
    return null;
  }
}
