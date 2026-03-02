import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button_widet.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/customer/presentation/bloc/wallet_bloc.dart';
import 'package:qawafi_app/features/customer/presentation/presentation/pages/wallet_page.dart';

import '../../../../../core/common/widgets/loader.dart';
import '../../../../../core/utils/show_success_dialog.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/validation/input_validation.dart';

class ChargeWalletPage extends StatelessWidget {
  ChargeWalletPage({super.key});

  static const String routeName = 'ChargeWallet';

  static route() => MaterialPageRoute(
        builder: (context) => ChargeWalletPage(),
        settings: const RouteSettings(name: routeName),
      );

  final TextEditingController _cardInput = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      body: DefaultTextStyle(
        style: const TextStyle(
          color: AppPallete.blackColor,
          fontFamily: 'Cairo',
        ),
        child: Container(
          width: double.infinity,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                const Text(
                  "كروت قوافي",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "الرجاء أدخال رقم الكرت المكون من 13 رقم",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _cardInput,
                    keyboardType: TextInputType.number,
                    validator: InputValidation.qawafiCardValidation(),
                    style: const TextStyle(
                      color: AppPallete.backgroundColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'ادخل الكرت',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppPallete.greyColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF677294).withOpacity(0.16),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF677294).withOpacity(0.16),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF677294).withOpacity(0.16),
                          width: 2, // Customize the width for the focused state
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<WalletBloc, WalletState>(
                    listener: (context, state) {
                      if (state is WalletFailure) {
                        showSnackBar(context, state.message);
                      }
                      if (state is WalletSuccess) {
                        Navigator.popUntil(
                            context,
                            (route) =>
                                route.settings.name == WalletPage.routeName);

                        showSuccessDialog(
                            title: "شكراً لك",
                            content: "لقد تمت عملية الدفع بنجاج.",
                            context: context);
                      }
                    },
                    builder: (context, state) {
                      return AppButtonWidget(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              state is! WalletLoading) {
                            context.read<WalletBloc>().add(
                                  WalletChargeEvent(
                                    cardNo: int.tryParse(_cardInput.text) ?? 0,
                                  ),
                                );
                          }
                        },
                        widget: state is WalletLoading
                            ? const Loader()
                            : Text(
                                'شحن',
                                style: TextStyle(
                                  color: AppPallete.whiteColor,
                                  fontSize: getProportionateScreenWidth(18),
                                ),
                              ),
                        height: 56,
                        color: AppPallete.blackColor,
                        textColor: AppPallete.whiteColor,
                        borderColor: AppPallete.transparentColor,
                        opicity: 1,
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
