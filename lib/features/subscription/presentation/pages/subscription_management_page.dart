import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/constants/constants.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/subscription_management_bloc/subscription_management_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/pages/cancel_subscription.dart';
import '../../../../core/common/widgets/app_button.dart';
import '../../../../core/localStorage/loacal_storage.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../init_dependencies.dart';
import '../../../customer/domain/entites/subscription.dart';
import '../../../webview/presentation/pages/webview_page.dart';
import '../widgets/subscription_app_bar.dart';
import 'subscribe_to_bunch_page.dart';

class SubscriptionManagementPage extends StatefulWidget {
  static const String routeName = '/SubscriptionManagement';
  static route() => MaterialPageRoute(
        builder: (context) => const SubscriptionManagementPage(),
        settings: const RouteSettings(name: routeName),
      );

  const SubscriptionManagementPage({super.key});

  @override
  State<SubscriptionManagementPage> createState() =>
      _SubscriptionManagementPageState();
}

class _SubscriptionManagementPageState
    extends State<SubscriptionManagementPage> {
  late LocalStorage _localStorage;
  String token = "";
  final List<Color> colors = [
    AppPallete.whiteColor.withOpacity(0.1),
    const Color(0xFFBB9F64).withOpacity(0.4),
    const Color(0xFFD2973F).withOpacity(0.6)
  ];

  Future<void> _initializeToken() async {
    final retrievedToken = await _localStorage.accessToken;

    token = retrievedToken.replaceAll("Bearer ", "");
    log('TOKEN: ' + token);
  }

  @override
  void initState() {
    context
        .read<SubscriptionManagementBloc>()
        .add(SubscriptionManagementFetch());
    super.initState();
    _localStorage = serviceLocator<LocalStorage>();

    _initializeToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const SubscriptionAppBar(title: "إدارة الإشتراكات"),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: SingleChildScrollView(
          child: Column(children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'نحن هنا لنجعل تجربتك معنا\nأكثر سلاسة وراحة',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AppUserSubscriptionCubit, AppUserSubscriptionState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AppUserSubscriptionSubscribed) {}
              },
              builder: (context, state) {
                if (state is AppUserSubscriptionSubscribed) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "تاريخ انتهاء الاشتراك : ${formatDateByyyyyMMdd(state.subscription.endDate)}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("متبقي:"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppPallete.whiteColor
                                          .withOpacity(0.1)),
                                  child: Text(
                                    state.subscription.remainingDays
                                            .toString() +
                                        " أيام" +
                                        (state.subscription.status == 'active'
                                            ? ' | تجديد تلقائي'
                                            : ''),
                                    style: const TextStyle(
                                        color: AppPallete.secondaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            // if (subscription != null) ...{
            //           const SizedBox(
            //             height: 20,
            //           ),
            //           Container(
            //             margin: const EdgeInsets.symmetric(horizontal: 20),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                     "تاريخ انتهاء الاشتراك : ${formatDateByyyyyMMdd(.endDate)}"),
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const Text("متبقي:"),
            //                     const SizedBox(
            //                       width: 5,
            //                     ),
            //                     Container(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 30, vertical: 5),
            //                       decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(20),
            //                           color:
            //                               AppPallete.whiteColor.withOpacity(0.1)),
            //                       child: Text(
            //                         subscription!.remainingDays.toString() +
            //                             " أيام" +
            //                             (subscription!.canceledAt == null
            //                                 ? ' | تجديد تلقائي'
            //                                 : ''),
            //                         style: const TextStyle(
            //                             color: AppPallete.secondaryColor),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         },
            BlocConsumer<SubscriptionManagementBloc,
                SubscriptionManagementState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SubscriptionManagementFailure) {
                  return Refresh(
                      message: state.message,
                      onRefresh: () => context
                          .read<SubscriptionManagementBloc>()
                          .add(SubscriptionManagementFetch()));
                }
                if (state is SubscriptionManagementLoading) {
                  return const Loader();
                }
                if (state is SubscriptionManagementSucess) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // if (state.bunches.isEmpty ||
                      //     index >= state.bunches.length) {
                      //   return const SizedBox
                      //       .shrink(); // لا تعرض أي عنصر إذا كانت القائمة فارغة أو إذا كان الفهرس غير صالح
                      // }
                      log(state.bunches.toString());
                      log((context.watch<AppUserSubscriptionCubit>().state
                              as AppUserSubscriptionSubscribed)
                          .subscription
                          .toString());
                      Subscription? subscription = (context
                              .watch<AppUserSubscriptionCubit>()
                              .state is AppUserSubscriptionSubscribed)
                          ? (state.bunches[index].subscriptionCosts!.any((cost) =>
                                  cost.subscriptionCostId ==
                                  (context
                                              .watch<AppUserSubscriptionCubit>()
                                              .state
                                          as AppUserSubscriptionSubscribed)
                                      .subscription
                                      .subscriptionCostId)
                              ? (context.watch<AppUserSubscriptionCubit>().state
                                      as AppUserSubscriptionSubscribed)
                                  .subscription
                              : null)
                          : null;

                      return BunchWidget(
                        color: colors[index % colors.length],
                        cost: state.bunches[index].subscriptionCosts![0].cost
                            .toString(),
                        isSubscribed: false,
                        subscription: subscription,
                        period: state.bunches[index].subscriptionName,
                        onPressed: () => subscription != null &&
                                subscription!.status == 'active'
                            ? Navigator.push(
                                context, CancelSubscriptionPage.route())
                            : Navigator.push(
                                context,
                                WebViewExample.route(
                                    token: token,
                                    costId: state
                                        .bunches[index]
                                        .subscriptionCosts![0]
                                        .subscriptionCostId),
                              ),
                        // Removed for ebtekar
                        //  showModalBottomSheet(
                        //   isScrollControlled: false,
                        //   context: context,
                        //   backgroundColor: AppPallete.whiteColor,
                        //   showDragHandle: true,
                        //   builder: (context) {
                        //     return subscription == null ||
                        //             subscription.canceledAt != null
                        //         ? Subscribe2BunchPage(
                        //             costs:
                        //                 state.bunches[index].subscriptionCosts!,
                        //             navigateTo: (int x) => print(x),
                        //           )
                        //         : CancelSubscriptionPage();
                        //   },
                        // ),
                        title: Constants.packages[index + 1] ?? "الباقة",
                        btnBorderColor: AppPallete.whiteColor,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: state.bunches.length,
                  );
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    ));
  }
}

class BunchWidget extends StatelessWidget {
  const BunchWidget({
    super.key,
    required this.title,
    required this.cost,
    required this.period,
    required this.isSubscribed,
    required this.onPressed,
    required this.color,
    required this.btnBorderColor,
    this.subscription,
  });
  final String title;
  final String cost;
  final String period;
  final bool isSubscribed;
  final VoidCallback onPressed;
  final Color color;
  final Color? btnBorderColor;
  final Subscription? subscription;

  @override
  Widget build(BuildContext context) {
    log(subscription?.status.toString() ?? 'A');
    print(
        '[QAWAFI_LOG] Subscription status: ${subscription?.status.toString()}');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 234,
      width: 342,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Positioned(
          left: 10,
          child: Image.asset(
            AppImages.LOGO_WHITE,
          ),
        ),
        if (subscription != null) ...{
          const Positioned(
            left: 20,
            top: 20,
            child: Icon(
              Icons.circle,
              color: Colors.green,
              size: 15,
            ),
          ),
        },
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppImages.LOGO_ON_CARD),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'إذا كنت ترغب في إلغاء الاشتراك، اضغط على "إلغاء الاشتراك" وتابع الخطوات. نود أن نذكرك بأنك تستطيع.',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    '$cost د.ل',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(22),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(22),
                    ),
                  ),
                  Text(
                    period,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: AppPallete.whiteColor.withOpacity(0.5)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Button
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          left: 20,
          child: SizedBox(
            child: AppButton(
              onPressed: onPressed,
              text: subscription != null
                  ? subscription!.status == 'active'
                      ? 'إلغاء التجديد تلقائي'
                      : 'إشتراك'
                  : "إشتراك",
              height: 42,
              color: color,
              borderColor: btnBorderColor,
            ),
          ),
        ),
      ]),
    );
  }
}



// return Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       BunchWidget(
//                         color: AppPallete.whiteColor.withOpacity(0.1),
//                         cost: "2",
//                         isSubscribed: false,
//                         period: "اسبوعي",
//                         onPressed: () => log((context.read<AppUserCubit>().state
//                                 as AppUserLoggedIn)
//                             .user
//                             .id),
//                         // onPressed: () => showModalBottomSheet(
//                         //   isScrollControlled: false,
//                         //   context: context,
//                         //   backgroundColor: AppPallete.whiteColor,
//                         //   showDragHandle: true,
//                         //   builder: (context) {
//                         //     return Subscribe2BunchPage();
//                         //   },
//                         // ),
//                         title: 'باقة رقم واحد',
//                         btnBorderColor: AppPallete.whiteColor,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       BunchWidget(
//                         color: const Color(0xFFBB9F64).withOpacity(0.4),
//                         cost: "8",
//                         isSubscribed: false,
//                         period: "شهري",
//                         onPressed: () => print('object'),
//                         title: 'باقة رقم أثنان',
//                         btnBorderColor: AppPallete.whiteColor,
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       BunchWidget(
//                         color: const Color(0xFFD2973F).withOpacity(0.6),
//                         cost: "20",
//                         isSubscribed: false,
//                         period: "3 أشهر",
//                         onPressed: () => print('object'),
//                         title: 'باقة رقم ثلاثة',
//                         btnBorderColor: AppPallete.whiteColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               );