import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button_widet.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/show_success_dialog.dart';
import 'package:qawafi_app/core/utils/size_config.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../../core/validation/input_validation.dart';
import '../bloc/change_password_bloc/change_password_bloc.dart';
import '../widgets/field_label.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static const String routeName = '/ChangePassword';
  static route() => MaterialPageRoute(
        builder: (context) => const ChangePasswordPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: 'تغيير كلمة المرور'),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const FieldLabel("كلمة المرور الحالية"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  validator: InputValidation.requiredValidation(),
                  style: const TextStyle(
                    color: AppPallete.backgroundColor,
                  ),
                  decoration: const InputDecoration(prefixIcon: AppIcon.lock),
                ),
                const SizedBox(
                  height: 20,
                ),
                const FieldLabel("كلمة  المرور الجديدة"),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _newPassword,
                  validator: InputValidation.requiredValidation(),
                  obscureText: true,
                  style: const TextStyle(
                    color: AppPallete.backgroundColor,
                  ),
                  decoration: const InputDecoration(prefixIcon: AppIcon.lock),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordFailure) {
                      showSnackBar(context, state.message);
                    }
                    if (state is ChangePasswordSuccess) {
                      Navigator.pop(context);
                      showSuccessDialog(
                          context: context,
                          title: "تمت العملية بنجاح",
                          content: state.message);
                    }
                  },
                  builder: (context, state) {
                    return AppButtonWidget(
                      widget: state is ChangePasswordLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: Loader(
                                color: AppPallete.whiteColor,
                              ),
                            )
                          : Text(
                              'موافق',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                              ),
                            ),
                      onPressed: () => context.read<ChangePasswordBloc>().add(
                            ChangePasswordDoEvent(
                                password: _password.text,
                                newPassword: _newPassword.text),
                          ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
