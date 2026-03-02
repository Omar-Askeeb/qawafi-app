import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';

import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/verify_subscription_bloc/verify_subscription_bloc.dart';

import '../../../../core/common/widgets/app_button_widet.dart';
import '../../../../core/utils/show_cancel_dialog.dart';
import '../../../../core/utils/size_config.dart';

// ignore: must_be_immutable
class CancelSubscriptionPage extends StatefulWidget {
  static const String routeName = 'CancelSubscription';

  static route() => MaterialPageRoute(
        builder: (context) => CancelSubscriptionPage(),
        settings: const RouteSettings(name: routeName),
      );

  CancelSubscriptionPage({
    super.key,
  });

  @override
  State<CancelSubscriptionPage> createState() => _Subscribe2BunchPageState();
}

class _Subscribe2BunchPageState extends State<CancelSubscriptionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: DefaultTextStyle(
            style: const TextStyle(fontFamily: 'Cairo'),
            child:
                BlocConsumer<VerifySubscriptionBloc, VerifySubscriptionState>(
              listener: (context, state) {
                if (state is VerifySubscriptionSuccess) {
                  Navigator.pop(context);
                  showCancelDialog(
                      content: "لن يتم تجديد الإشتراك تلقائياً بعد الأن",
                      context: context,
                      title: "تم إلغاء التجديد التلقائي");
                }
              },
              builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        " الغاء التجديد التلقائي في الباقة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppPallete.blackColor),
                      ),
                      Text(
                        "يمكنك الإشتراك في باقة جديدة",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppPallete.blackColor.withOpacity(0.3)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppButtonWidget(
                          onPressed: () => context
                              .read<VerifySubscriptionBloc>()
                              .add(VerifySubscriptionCancelEvent()),
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
                    ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
