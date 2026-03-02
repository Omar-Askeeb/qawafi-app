import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/widgets/app_button_widet.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/show_success_dialog.dart';

import '../../../../core/utils/size_config.dart';
import '../bloc/user_info_bloc/user_info_bloc.dart';
import '../widgets/field_label.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage(
      {super.key, required this.name, required this.phoneNumber});

  static const String routeName = '/UserInfo';
  static route({required String name, required String phoneNumber}) =>
      MaterialPageRoute(
        builder: (context) =>
            UserInfoPage(name: name, phoneNumber: phoneNumber),
        settings: const RouteSettings(name: routeName),
      );
  final String name;
  final String phoneNumber;
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

final TextEditingController _phoneNumber = TextEditingController();

final TextEditingController _name = TextEditingController();

final _formKey = GlobalKey<FormState>();

class _UserInfoPageState extends State<UserInfoPage> {
  bool isEnabled = false;

  @override
  void initState() {
    _phoneNumber.text = widget.phoneNumber.replaceAll('218', "");
    _name.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: "البيانات الشخصية"),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        color: AppPallete.whiteColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(80)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(AppImages.LOGO_WHITE_BIG),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: FieldLabel(
                  'الإسم الكامل',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _name,
                          enabled: isEnabled,
                          style: const TextStyle(color: AppPallete.blackColor),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppPallete.blackColor,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          isEnabled = !isEnabled;
                        }),
                        child: Icon(
                          Icons.edit,
                          color: isEnabled
                              ? AppPallete.blackColor
                              : AppPallete.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: FieldLabel(
                  'رقم الهاتف',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: TextFormField(
                  style: const TextStyle(color: AppPallete.blackColor),
                  controller: _phoneNumber,
                  enabled: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppPallete.blackColor,
                    ),
                    suffixText: "218+",
                    suffixStyle: TextStyle(
                      color: AppPallete.blackColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocConsumer<UserInfoBloc, UserInfoState>(
                listener: (context, state) {
                  if (state is UserInfoSuccess) {
                    showSuccessDialog(
                        context: context,
                        title: "تم تغيير الأسم بنجاح",
                        content: "");
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppButtonWidget(
                      widget: state is UserInfoLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: Loader(),
                            )
                          : Text(
                              "حفظ التغييرات",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                              ),
                            ),
                      onPressed: _updateUserInfo,
                      height: 55,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  _updateUserInfo() {
    if (isEnabled &&
        _formKey.currentState!.validate() &&
        _name.text != widget.name) {
      context.read<UserInfoBloc>().add(
            UserInfoUpdateEvent(
              name: _name.text,
              userId: (context.read<AppUserCubit>().state as AppUserLoggedIn)
                  .user
                  .id,
            ),
          );
      return;
    }
    showSnackBar(context, "الرجاء تعديل القيمة أولاً");
  }
}
