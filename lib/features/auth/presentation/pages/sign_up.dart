import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/theme/app_icons.dart';
import 'package:qawafi_app/core/utils/phone_number_string.dart';
import 'package:qawafi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qawafi_app/features/auth/presentation/pages/widgets/privacy_policy.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/validation/input_validation.dart';
import '../widgets/divider.dart';
import 'otp.dart';
import 'widgets/auth_field_label.dart';
import 'widgets/button.dart';
import 'widgets/fields_spacer.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullName = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _approved = false;
  bool _canAprrove = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
          if (state is AuthOtpState) {
            Navigator.push(
              context,
              Otp.route(
                name: state.name,
                phoneNumber: state.phoneNumber,
                passowrd: state.password,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const AuthFieldLabel(
                      'الاسم الكامل',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _fullName,
                      validator: InputValidation.requiredValidation(),
                      style: const TextStyle(
                        color: AppPallete.backgroundColor,
                      ),
                      decoration:
                          const InputDecoration(prefixIcon: AppIcon.person),
                    ),
                    const FieldSpacer(),
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
                        prefixIcon: AppIcon.phoneNumber,
                        suffix: Text(
                          '+218',
                          style: TextStyle(color: AppPallete.blackColor),
                        ),
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
                      obscureText: true,
                      validator: InputValidation.requiredPasswordValidation(),
                      style: const TextStyle(
                        color: AppPallete.backgroundColor,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: AppIcon.lock,
                      ),
                    ),
                    const FieldSpacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _canAprrove ? _approve() : null;
                            _approve();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppPallete.secondaryColor,
                            ),
                            height: 20,
                            width: 20,
                            child: Center(
                              child: _approved ? AppIcon.check : Container(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _openPopup();
                            // showModalBottomSheet(
                            //   isScrollControlled: true,
                            //   context: context,
                            //   backgroundColor: AppPallete.whiteColor,
                            //   showDragHandle: false,
                            //   builder: (context) {
                            //     return PrivacyPolicy(
                            //       onPressed: () {
                            //         _approve(forceTrue: true);
                            //       },
                            //       isApproved: _approved,
                            //     );
                            //   },
                            // );
                          },
                          child: const Text('اوافق على سياسة الخصوصية'),
                        )
                      ],
                    ),
                    const FieldSpacer(),
                    const AuthDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthButton(
                      onPressed: () {
                        // Navigator.push(context, Otp.route());
                        if (formKey.currentState!.validate() && _approved) {
                          context.read<AuthBloc>().add(
                                AuthRequestOtp(
                                  phoneNumber:
                                      getPhoneNumber(_phoneNumber.text.trim()),
                                  password: _password.text.trim(),
                                  name: _fullName.text.trim(),
                                ),
                              );
                        } else if (!_approved) {
                          showSnackBar(
                            context,
                            "لابد من الموافقة على سياسة الخصوصية",
                          );
                        }
                      },
                      text: 'إنشاء حساب',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _approve({bool? forceTrue}) {
    // if (!_canAprrove) {
    if (forceTrue != null) {
      _canAprrove = true;
    } else if (!_canAprrove) {
      _openPopup();
      return;
    }
    setState(() {
      _approved = forceTrue ?? !_approved;
    });
    // }
  }

  _openPopup() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: AppPallete.whiteColor,
      showDragHandle: false,
      builder: (context) {
        return PrivacyPolicy(
          onPressed: () {
            _approve(forceTrue: true);
          },
          isApproved: _approved,
        );
      },
    );
  }
}
