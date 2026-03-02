import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/verify_subscription_bloc/verify_subscription_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/pages/subscription_management_page.dart';

import '../../../../core/common/widgets/app_button.dart';
import '../../../../core/common/widgets/app_button_widet.dart';
import '../../../../core/utils/show_success_dialog.dart';
import '../../../../core/utils/size_config.dart';
import '../../data/models/subscription_cost_model.dart';

class VerifySubscriptionPage extends StatelessWidget {
  static const String routeName = 'VerifySubscription';

  static route(
          {required SubscriptionCostModel cost,
          required Function(int) navigateTo}) =>
      MaterialPageRoute(
        builder: (context) => VerifySubscriptionPage(
          cost: cost,
          navigateTo: navigateTo,
        ),
        settings: const RouteSettings(name: routeName),
      );

  VerifySubscriptionPage({
    super.key,
    required this.cost,
    required this.navigateTo,
  });

  final SubscriptionCostModel cost;
  final Function(int) navigateTo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppImages.walletVerifySubscription),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سيتم خصم ",
                      style: TextStyle(
                        color: AppPallete.blackColor,
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cost.cost + " د.ل",
                      style: TextStyle(
                        color: AppPallete.primaryColor,
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " من المحفظة",
                      style: TextStyle(
                        color: AppPallete.blackColor,
                        fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Text(
                      "بعد إتمام عملية الدفع، يمكنك البدء في الاستفادة من جميع المزايا التي توفرها الباقة المختارة.",
                      style: TextStyle(
                        color: AppPallete.greyColor,
                        fontSize: getProportionateScreenWidth(14),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                BlocConsumer<VerifySubscriptionBloc, VerifySubscriptionState>(
                  listener: (context, state) {
                    if (state is VerifySubscriptionSuccess) {
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name ==
                              SubscriptionManagementPage.routeName);
                      showSuccessDialog(
                          content:
                              "لقد تم تفعيل اشتراكك. يمكنك الآن الاستمتاع بكل المزايا التي توفرها باقتك.",
                          context: context,
                          title: "تمت عملية الخصم بنجاح!");
                    }
                    if (state is VerifySubscriptionFailure) {
                      showSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppButtonWidget(
                        onPressed: () =>
                            context.read<VerifySubscriptionBloc>().add(
                                  VerifySubscriptionWalletSubscribeEvent(
                                    subscriptionCostId: cost.subscriptionCostId,
                                  ),
                                ),
                        widget: state is VerifySubscriptionLoading
                            ? const Loader()
                            : Text(
                                'موافق',
                                style: TextStyle(
                                  color: AppPallete.whiteColor,
                                  fontSize: getProportionateScreenWidth(18),
                                ),
                              ),
                        height: 56,
                        color: AppPallete.blackColor,
                        borderColor: AppPallete.transparentColor,
                        opicity: 1,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    onPressed: () => Navigator.pop(context),
                    text: "الغاء",
                    height: 56,
                    color: AppPallete.whiteColor,
                    textColor: AppPallete.blackColor,
                    borderColor: AppPallete.blackColor,
                    opicity: 1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
