import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/phone_number_string.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/auth/presentation/pages/otp.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/validation/input_validation.dart';
import '../bloc/auth_bloc.dart';
import 'widgets/reset_password_button.dart';

class ResetPasswordPopup extends StatefulWidget {
  ResetPasswordPopup({super.key});

  @override
  State<ResetPasswordPopup> createState() => _ResetPasswordPopupState();
}

class _ResetPasswordPopupState extends State<ResetPasswordPopup> {
  final TextStyle _header =
      const TextStyle(fontSize: 20, color: AppPallete.blackColor);

  final TextStyle _subTitle =
      const TextStyle(fontSize: 14, color: Color(0xFFA7A9B7));

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneNumber = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: AppPallete.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
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
                        name: '',
                        phoneNumber: state.phoneNumber,
                        passowrd: '',
                        isReset: true,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Loader();
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "هل نسيت كلمة المرور ؟",
                            style: _header,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'أدخل رقم الهاتف لعمليات التحقق',
                            style: _subTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'سوف نرسل رمز مكون من 4 أرقام إلى رقم الهاتف',
                            style: _subTitle,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneNumber,
                          onTap: () {
                            // scrollController
                          },
                          keyboardType: TextInputType.phone,
                          validator: InputValidation.phoneNumberValidation(),
                          style: const TextStyle(
                            color: AppPallete.backgroundColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'رقم الهاتف',
                            prefixIcon: AppIcon.phoneNumber,
                            filled: true,
                            fillColor: AppPallete.whiteColor,
                            labelStyle: const TextStyle(
                                color: AppPallete.backgroundColor),
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppPallete.greyColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppPallete.greyColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            // focusedBorder: _border(AppPallete.primaryColor),
                            // errorBorder: _border(AppPallete.errorColor),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (state is AuthFailure) ...{
                          Text(
                            state.message,
                            style: TextStyle(color: AppPallete.errorColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        },
                        ResetPasswordButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthRequestOtp(
                                      phoneNumber: getPhoneNumber(
                                        _phoneNumber.text.trim(),
                                      ),
                                      name: '',
                                      password: '',
                                    ),
                                  );
                            }
                          },
                          text: 'استمرار',
                          color: AppPallete.blackColor,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
