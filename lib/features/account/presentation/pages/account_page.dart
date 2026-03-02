import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/widgets/aboutApp.dart';
import 'package:qawafi_app/core/common/widgets/app_button_widet.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/SizeConfigPercentage.dart';
import 'package:qawafi_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:qawafi_app/features/auth/presentation/pages/widgets/privacy_policy_noBotton.dart';
import 'package:qawafi_app/features/auth/presentation/warpper/auth_warpper.dart';
import 'package:qawafi_app/features/subscription/presentation/pages/subscription_management_page.dart';
import 'package:qawafi_app/features/support/presentation/pages/supportPage.dart';

import '../../../../core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import '../../../../core/utils/navigator_key.dart';
import '../../../../core/utils/size_config.dart';
import '../../../customer/domain/entites/subscription.dart';
import '../../data/models/account_opation_list.dart';
import 'user_info_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  static const String routeName = '/Account';
  static route() => MaterialPageRoute(
        builder: (context) => const AccountPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Subscription? subscription;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subscription = context.watch<AppUserSubscriptionCubit>().state
            is AppUserSubscriptionSubscribed
        ? (context.watch<AppUserSubscriptionCubit>().state
                as AppUserSubscriptionSubscribed)
            .subscription
        : null;
    return ScaffoldWithBackgroundImage(
      scaffod: Scaffold(
        appBar: const QawafiAppBar(title: 'حسابي'),
        body: BlocConsumer<AppUserCubit, AppUserState>(
          listener: (context, appUserState) {
            // TODO: implement listener
          },
          builder: (context, appUserState) {
            if (appUserState is AppUserLoggedIn) {
              log((context.read<AppUserCubit>().state as AppUserLoggedIn)
                  .user
                  .id);
              return Column(
                children: [
                  BlocConsumer<AppUserSubscriptionCubit,
                      AppUserSubscriptionState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AccountInfoWidget(
                              title: "حالة الحساب",
                              description: context.read<AppUserCubit>().state
                                      is AppUserLoggedIn
                                  ? (context.read<AppUserCubit>().state
                                          as AppUserLoggedIn)
                                      .user
                                      .customerType
                                  : '',
                              isSubscribed: context.read<AppUserCubit>().state
                                      is AppUserLoggedIn
                                  ? (!((context.read<AppUserCubit>().state
                                              as AppUserLoggedIn)
                                          .user
                                          .customerType ==
                                      'Guest'))
                                  : false),
                          // const SizedBox(
                          //     height: 60,
                          //     child: VerticalDivider(
                          //       color: AppPallete.whiteColor,
                          //     )),
                          // GestureDetector(
                          //   onTap: () =>
                          //       Navigator.push(context, WalletPage.route()),
                          //   child: Row(
                          //     children: [
                          //       AccountInfoWidget(
                          //           title: "الرصيد",
                          //           description: context
                          //                   .read<AppUserCubit>()
                          //                   .state is AppUserLoggedIn
                          //               ? (context.read<AppUserCubit>().state
                          //                           as AppUserLoggedIn)
                          //                       .user
                          //                       .balance
                          //                       .toString() +
                          //                   " د.ل"
                          //               : "0 د.ل",
                          //           isSubscribed: null),
                          //       const Icon(Icons.add_circle)
                          //     ],
                          //   ),
                          // ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   (appUserState).user.fullName,
                          //   style: const TextStyle(fontSize: 22),
                          // ),
                          Text(
                            (context.read<AppUserCubit>().state
                                    as AppUserLoggedIn)
                                .user
                                .phoneNumber
                                .toString(),
                            style: TextStyle(
                                fontSize: 22,
                                color: AppPallete.whiteColor.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AccountAcctionOpationsList(
                            title: "حسابي",
                            items: [
                              AccountOpation(
                                title: 'البيانات الشخصية',
                                iconPath: AppImages.profileIcon,
                                action: () => Navigator.push(
                                  context,
                                  UserInfoPage.route(
                                      name: (context.read<AppUserCubit>().state
                                              as AppUserLoggedIn)
                                          .user
                                          .name,
                                      phoneNumber: (context
                                              .read<AppUserCubit>()
                                              .state as AppUserLoggedIn)
                                          .user
                                          .phoneNumber),
                                ),
                              ),
                              AccountOpation(
                                title: 'إدارة الإشتراكات',
                                iconPath: AppImages.receiptTextIcon,
                                action: () => Navigator.push(
                                  context,
                                  SubscriptionManagementPage.route(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AccountAcctionOpationsList(
                            title: "الاعدادات",
                            items: [
                              // AccountOpation(
                              //   title: 'تغيير كلمة المرور',
                              //   iconPath: AppImages.lockIcon,
                              //   action: () => Navigator.push(
                              //       context, ChangePasswordPage.route()),
                              // ),
                              AccountOpation(
                                title: 'سياسة الخصوصية',
                                iconPath: AppImages.shieldSecurityIcon,
                                action: () => Navigator.push(
                                    context, PrivacyPolicyNoButton.route()),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AccountAcctionOpationsList(
                            title: "الدعم الفني",
                            items: [
                              AccountOpation(
                                title: 'تواصل معنا',
                                iconPath: AppImages.callCallingIcon,
                                action: () => Navigator.push(
                                    context, SupportPage.route()),
                              ),
                              AccountOpation(
                                title: 'حول التطبيق',
                                iconPath: AppImages.warningIcon,
                                action: () =>
                                    Navigator.push(context, Aboutapp.route()),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is AuthSignoutState) {
                                navigatorKey.currentState!.pushAndRemoveUntil(
                                    AuthWarpper.route(), (route) => false);
                                // Navigator.pushAndRemoveUntil(
                                //     context, AuthWarpper.route(), (route) => false);
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: AppButtonWidget(
                                  onPressed: () => state is AuthLoading
                                      ? null
                                      : context
                                          .read<AuthBloc>()
                                          .add(AuthSignOut()),
                                  widget: state is AuthLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Loader(),
                                        )
                                      : Text(
                                          "تسجيل الخروج",
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(18),
                                          ),
                                        ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class AccountAcctionOpationsList extends StatelessWidget {
  const AccountAcctionOpationsList({
    super.key,
    required this.title,
    required this.items,
  });
  final String title;
  final List<AccountOpation> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 30.0,
                bottom: 10,
              ),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: AppPallete.whiteColor.withOpacity(0.5)),
              ),
            )),
        Container(
          height: items.length > 1 ? 116 : (116 / 2),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: AppPallete.whiteColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: items[0].action,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: AppPallete.secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(items[0].iconPath),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      items[0].title,
                      style: TextStyle(
                          fontSize: 17,
                          color: AppPallete.whiteColor.withOpacity(0.8)),
                    ),
                    const Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.arrow_forward_ios, size: 20)),
                    ),
                  ],
                ),
              ),
              if (items.length > 1) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: AppPallete.whiteColor.withOpacity(0.1)),
                ),
                GestureDetector(
                  onTap: items[1].action,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppPallete.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(items[1].iconPath),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        items[1].title,
                        style: TextStyle(
                            fontSize: 17,
                            color: AppPallete.whiteColor.withOpacity(0.8)),
                      ),
                      const Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.arrow_forward_ios, size: 20)),
                      ),
                    ],
                  ),
                ),
              }
              // GestureDetector(
              //   onTap: items[0].action,
              //   child: ListTile(

              //     leading: const Icon(Icons.person),
              //     title: Text(
              //       items[0].title,
              //       style: TextStyle(
              //           fontSize: 17,
              //           color: AppPallete.whiteColor.withOpacity(0.8)),
              //     ),
              //     trailing: const Icon(Icons.arrow_forward_ios, size: 20),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Divider(color: AppPallete.whiteColor.withOpacity(0.3)),
              // ),
              // GestureDetector(
              //   onTap: items[1].action,
              //   child: ListTile(
              //     leading: const Icon(Icons.person),
              //     title: Text(
              //       items[1].title,
              //       style: TextStyle(
              //           fontSize: 17,
              //           color: AppPallete.whiteColor.withOpacity(0.8)),
              //     ),
              //     trailing: const Icon(Icons.arrow_forward_ios, size: 20),
              //   ),
              // ),
            ],
          ),
          // child: ListView.separated(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: items.length,
          //   itemBuilder: (context, index) {
          //     return GestureDetector(
          //       onTap: items[index].action,
          //       child: ListTile(
          //         leading: const Icon(Icons.person),
          //         title: Text(
          //           items[index].title,
          //           style: TextStyle(
          //               fontSize: 17,
          //               color: AppPallete.whiteColor.withOpacity(0.8)),
          //         ),
          //         trailing: const Icon(Icons.arrow_forward_ios, size: 20),
          //       ),
          //     );
          //   },
          //   separatorBuilder: (context, index) => Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //     child: Divider(color: AppPallete.whiteColor.withOpacity(0.3)),
          //   ),
          // ),
        )
      ],
    );
  }
}

class AccountInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool? isSubscribed;
  const AccountInfoWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isSubscribed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfigPercentage.safeBlockHorizontal! * 40,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSubscribed != null) ...{
              Icon(
                Icons.circle,
                color: isSubscribed! ? Colors.green : AppPallete.errorColor,
                size: 10,
              ),
              const SizedBox(
                width: 10,
              ),
            },
            Text(
              isSubscribed == null
                  ? description
                  : isSubscribed!
                      ? "فعال"
                      : 'غير فعال',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(22),
              ),
            )
          ],
        )
      ]),
    );
  }
}
