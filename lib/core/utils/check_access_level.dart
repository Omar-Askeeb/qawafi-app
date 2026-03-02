import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/go_to_subscription.dart';
import '../../features/auth/presentation/pages/tab_view_wrapper.dart';
import '../../features/subscription/presentation/pages/subscription_management_page.dart';
import '../../features/webview/presentation/pages/auth_webview.dart';
import '../common/cubits/app_user/app_user_cubit.dart';
import 'navigator_key.dart';
import 'show_snackbar_action.dart';

void checkAccessLevel(
    {required BuildContext context,
    required Function function,
    bool isFree = false}) {
  if (isFree ||
      (context.read<AppUserCubit>().state is AppUserLoggedIn &&
          (context.read<AppUserCubit>().state as AppUserLoggedIn)
                  .user
                  .customerType ==
              'Subscriber')) {
    function();
    return;
  }

  if ((context.read<AppUserCubit>().state is AppUserInitial)) {
    RedirectSignupFlagSingleton().isRedirect = true;
    // showSnackBarAction(context,
    //     "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى",
    //     onPressed: () => navigatorKey.currentState!.push(
    //           TabViewWrapper.route(1),
    //         ),
    //     buttonText: "حساب جديد");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "تنبيه",
            style: TextStyle(
              //  fontSize: 16.0,
              color: AppPallete.libyanTitlesCardsTitleColor,
            ),
          )),
          content: Text(
              "عفواً لست مشترك، الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى"),
          actions: [
            TextButton(
              child: Center(
                  child: Text(
                "اشترك الأن",
                style: TextStyle(
                  fontSize: 20,
                  color: AppPallete.libyanTitlesCardsTitleColor,
                ),
              )),
              onPressed: () {
                Navigator.of(context).pop(); // لإغلاق النافذة
                navigatorKey.currentState!.push(FlutterWebView.route());
              },
            ),
          ],
        );
      },
    );
  }

  if ((context.read<AppUserCubit>().state is AppUserLoggedIn)) {
    //   showSnackBarAction(context,
    //       "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى",
    //       onPressed: () =>
    //           navigatorKey.currentState!.push(SubscriptionManagementPage.route()),
    //       buttonText: "إشتراك");
    // }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "تنبيه",
            style: TextStyle(
              //  fontSize: 16.0,
              color: AppPallete.libyanTitlesCardsTitleColor,
            ),
          )),
          content: Text(
              "عفواً لست مشترك، الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى"),
          actions: [
            TextButton(
              child: Center(
                  child: Text(
                "اشترك الأن",
                style: TextStyle(
                  fontSize: 20,
                  color: AppPallete.libyanTitlesCardsTitleColor,
                ),
              )),
              onPressed: () {
                Navigator.of(context).pop(); // لإغلاق النافذة
                navigatorKey.currentState!.push(TabViewWrapper.route(1));
              },
            ),
          ],
        );
      },
    );
  }
}
  // if ((context.read<AppUserCubit>().state is AppUserInitial)) {
  //   RedirectSignupFlagSingleton().isRedirect = true;
  //   showSnackBarAction(context,
  //       "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى",
  //       onPressed: () => navigatorKey.currentState!.push(
  //             TabViewWrapper.route(1),
  //           ),
  //       buttonText: "حساب جديد");
  // }

  // if ((context.read<AppUserCubit>().state is AppUserLoggedIn)) {
  //   showSnackBarAction(context,
  //       "عفواً لست مشترك الرجاء الإشتراك حتى يمكنك الإستمتاع بهذا المحتوى",
  //       onPressed: () =>
  //           navigatorKey.currentState!.push(SubscriptionManagementPage.route()),
  //       buttonText: "إشتراك");
  // }