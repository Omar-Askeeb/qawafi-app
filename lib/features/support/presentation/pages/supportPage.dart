import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button_widet.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/theme/app_icons.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/core/utils/show_success_dialog.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/core/validation/input_validation.dart';
import 'package:qawafi_app/features/account/presentation/widgets/account_appbar.dart';
import 'package:qawafi_app/features/support/presentation/bloc/contact_bloc.dart';

class SupportPage extends StatefulWidget {
  const SupportPage();

  static const String routeName = '/SupportPage';
  static route() => MaterialPageRoute(
        builder: (context) => const SupportPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController _FullName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _Titel = TextEditingController();
  final TextEditingController _Message = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _areAllFieldsFilled() {
    return _FullName.text.isNotEmpty &&
        _phoneNumber.text.isNotEmpty &&
        _Titel.text.isNotEmpty &&
        _Message.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'تواصل معنا'),
        body: Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الاسم الكامل',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _FullName,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'أدخل الاسم كامل ',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 14),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال الاسم الكامل';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'رقم الهاتف',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
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
                            hintText: 'أدخل رقم الهاتف',
                            hintStyle:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'العنوان',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _Titel,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'أدخل العنوان',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 14),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال العنوان';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الرسالة',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            validator: InputValidation.textLenthAndRequried(),
                            controller: _Message,
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              hintText: 'أدخل محتوى الرسالة',
                              hintStyle: TextStyle(
                                  color: Colors.black26, fontSize: 14),
                            ),
                            maxLines: 5,
                          ),
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: BlocConsumer<ContactBloc, ContactState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is ContactFailure) {
                                showSnackBar(context, state.message);
                              }
                              if (state is ContactLoaded) {
                                Navigator.pop(context);
                                showSuccessDialog(context: context, title: "تم الإرسال", content: "شكرا للتواصل معنا .. ");
                              }
                            },
                            builder: (context, state) {
                              return AppButtonWidget(
                                onPressed: () {
                                  if (state is ContactLoading) {
                                    return;
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    if (_areAllFieldsFilled()) {
                                      print('All fields are filled!');
                                      context.read<ContactBloc>().add(
                                          ContactSendEvent(
                                              fullName: _FullName.text,
                                              phoneNumber: _phoneNumber.text,
                                              email: 'Test@Test.com',
                                              title: _Titel.text,
                                              content: _Message.text));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please fill all fields!')),
                                      );
                                    }
                                  }
                                },
                                widget: state is ContactLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Loader(),
                                      )
                                    : Text(
                                        "إرسال",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(18),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
