import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/theme/app_icons.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/navigator_key.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qawafi_app/features/auth/presentation/widgets/divider.dart';

import '../../../../core/common/pages/my_app_page.dart';
import '../../../../core/utils/phone_number_string.dart';
import '../../../../core/validation/input_validation.dart';
import 'reset_password_popup.dart';
import 'widgets/auth_field_label.dart';
import 'widgets/button.dart';
import 'widgets/fields_spacer.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
          if (state is AuthSuccess) {
            //TESTING THIS
            navigatorKey.currentState!.pushAndRemoveUntil(
              MyAppPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const AuthFieldLabel(
                      'رقم الهاتف',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      validator: InputValidation.phoneNumberValidation(),
                      style: const TextStyle(
                        color: AppPallete.backgroundColor,
                      ),
                      decoration: const InputDecoration(
                        suffix: Text(
                          '+218',
                          style: TextStyle(color: AppPallete.blackColor),
                        ),
                        prefixIcon: AppIcon.phoneNumber,
                      ),
                    ),
                    const FieldSpacer(),
                    const AuthFieldLabel(
                      'كلمة المرور',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _password,
                      validator: InputValidation.requiredPasswordValidation(),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
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
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: AppPallete.whiteColor,
                          showDragHandle: true,
                          builder: (context) {
                            return ResetPasswordPopup();
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'هل نسيت كلمة المرور ؟',
                          style: TextStyle(
                              color: AppPallete.whiteColor.withOpacity(0.8)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  phoneNumber:
                                      getPhoneNumber(_phoneNumber.text.trim()),
                                  password: _password.text.trim(),
                                ),
                              );
                        }
                      },
                      text: "تسجيل الدخول",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AuthDivider(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
