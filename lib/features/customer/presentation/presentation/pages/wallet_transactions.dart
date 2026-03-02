import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/constants/app_images.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/features/customer/presentation/bloc/wallet_transactions_bloc/wallet_transactions_bloc.dart';

class WalletTransactionsPage extends StatefulWidget {
  const WalletTransactionsPage({super.key});

  static const String routeName = 'WalletTransactions';

  static route() => MaterialPageRoute(
        builder: (context) => const WalletTransactionsPage(),
        settings: const RouteSettings(name: routeName),
      );

  @override
  State<WalletTransactionsPage> createState() => _WalletTransactionsPageState();
}

class _WalletTransactionsPageState extends State<WalletTransactionsPage> {
  @override
  void initState() {
    context.read<WalletTransactionsBloc>().add(WalletTransactionsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: DefaultTextStyle(
        style: const TextStyle(fontFamily: 'Cairo'),
        child: Column(
          children: [
            const Text(
              "العمليات السابقة",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<WalletTransactionsBloc, WalletTransactionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is WalletTransactionsFailure) {
                  return Refresh(
                      message: state.message, onRefresh: () => print('object'));
                }
                if (state is WalletTransactionsLoading) {
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Loader(),
                      ],
                    ),
                  );
                }
                if (state is WalletTransactionsLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48),
                                  color:
                                      AppPallete.whiteColor.withOpacity(0.2)),
                              child: Image.asset(AppImages.LOGO_WHITE_2)),
                          title: Text(
                            state.transactions[index].description,
                            style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.transactions[index].date,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                  color:
                                      AppPallete.whiteColor.withOpacity(0.6)),
                            ),
                          ),
                          trailing: Text(
                            state.transactions[index].amount + " د.ل",
                            style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: Divider(
                            color: AppPallete.greyColor.withOpacity(0.5),
                          )),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      )),
    );
  }
}
