import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/widgets/appbar.dart';
import 'package:qawafi_app/core/common/widgets/background_image_scaffold.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/size_config.dart';
import 'package:qawafi_app/features/customer/presentation/presentation/pages/wallet_transactions.dart';

import '../../../../../core/localStorage/loacal_storage.dart';
import '../../../../../init_dependencies.dart';
import '../../../../webview/presentation/pages/webview_page_charge_wallet.dart';
import 'charge_wallet_page.dart';

class WalletPage extends StatefulWidget {
  static const String routeName = 'Wallet';

  static route() => MaterialPageRoute(
        builder: (context) => const WalletPage(),
        settings: const RouteSettings(name: routeName),
      );

  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late LocalStorage _localStorage;
  String token = "";

  @override
  void initState() {
    super.initState();
    _localStorage = serviceLocator<LocalStorage>();

    _initializeToken();
  }

  Future<void> _initializeToken() async {
    final retrievedToken = await _localStorage.accessToken;

    token = retrievedToken.replaceAll("Bearer ", "");
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundImage(
        scaffod: Scaffold(
      appBar: const QawafiAppBar(title: 'المحفظة'),
      body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: Container(
          width: double.infinity,
          child: Column(children: [
            const Text(
              "رصيد المحفظة",
              style: TextStyle(fontSize: 16.63, color: AppPallete.greyColor),
            ),
            BlocConsumer<AppUserCubit, AppUserState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (context.read<AppUserCubit>().state as AppUserLoggedIn)
                              .user
                              .balance
                              .toString() +
                          ' د.ل',
                      style: const TextStyle(
                        fontSize: 40,
                        color: AppPallete.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      WebViewChargeWallet.route(
                        token: token,
                        customerId: (context.read<AppUserCubit>().state
                                as AppUserLoggedIn)
                            .user
                            .id,
                      ),
                    );
                  },
                  // onTap: () => showModalBottomSheet(
                  //   isScrollControlled: false,
                  //   context: context,
                  //   backgroundColor: AppPallete.whiteColor,
                  //   showDragHandle: true,
                  //   builder: (context) {
                  //     return ChargeWalletPage();
                  //   },
                  // ),
                  child: const WalletAction(
                    icon: Icons.add,
                    title: 'شحن المحفظة',
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: false,
                    context: context,
                    backgroundColor: const Color(0xFF1A1A19),
                    showDragHandle: true,
                    builder: (context) {
                      return const WalletTransactionsPage();
                    },
                  ),
                  child: const WalletAction(
                    icon: Icons.history,
                    title: 'العمليات السابقة',
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }
}

class WalletAction extends StatelessWidget {
  const WalletAction({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getProportionateScreenWidth(53.1),
          width: getProportionateScreenWidth(53.1),
          decoration: BoxDecoration(
            color: AppPallete.secondaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(53.1),
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12.39, color: AppPallete.greyColor),
        )
      ],
    );
  }
}
