import 'dart:developer';

import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawafi_app/core/common/widgets/app_button.dart';
import 'package:qawafi_app/core/common/widgets/loader.dart';
import 'package:qawafi_app/core/common/widgets/refresh.dart';
import 'package:qawafi_app/core/theme/app_pallete.dart';
import 'package:qawafi_app/core/utils/show_snackbar.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_cost_model.dart';
import 'package:qawafi_app/features/subscription/presentation/blocs/paymnet_bloc/payment_bloc.dart';
import 'package:qawafi_app/features/subscription/presentation/pages/verify_subscription_page.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/localStorage/loacal_storage.dart';
import '../../../../init_dependencies.dart';
import '../../../webview/presentation/pages/webview_page.dart';

// ignore: must_be_immutable
class Subscribe2BunchPage extends StatefulWidget {
  static const String routeName = 'Subscribe2Bunch';

  static route(
          {required List<SubscriptionCostModel> costs,
          required Function(int) navigateTo}) =>
      MaterialPageRoute(
        builder: (context) => Subscribe2BunchPage(
          costs: costs,
          navigateTo: navigateTo,
        ),
        settings: const RouteSettings(name: routeName),
      );

  Subscribe2BunchPage({
    super.key,
    required this.costs,
    required this.navigateTo,
  });

  final List<SubscriptionCostModel> costs;
  final Function(int) navigateTo;

  @override
  State<Subscribe2BunchPage> createState() => _Subscribe2BunchPageState();
}

class _Subscribe2BunchPageState extends State<Subscribe2BunchPage> {
  late LocalStorage _localStorage;
  String token = "";
  int _selectedMethodId = 0;

  _setSelectedMethod(int? value) {
    setState(() {
      _selectedMethodId = value ?? 0;
    });
  }

  @override
  void initState() {
    context.read<PaymentBloc>().add(PaymentFetchEvent());

    super.initState();
    _localStorage = serviceLocator<LocalStorage>();

    _initializeToken();
  }

  Future<void> _initializeToken() async {
    final retrievedToken = await _localStorage.accessToken;

    token = retrievedToken.replaceAll("Bearer ", "");
    log('TOKEN: ' + token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      body: SizedBox(
        width: double.infinity,
        child: DefaultTextStyle(
          style: const TextStyle(fontFamily: 'Cairo'),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Text(
              'الاشتراك في الباقة والدفع',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.blackColor),
            ),
            Text(
              'قم بأختيار الطريقة المفضلة لديك للاشتراك في الباقة',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppPallete.blackColor.withOpacity(0.3)),
            ),
            BlocConsumer<PaymentBloc, PaymentState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is PaymentFailure) {
                    return Refresh(
                        message: state.message,
                        onRefresh: () => context.read<PaymentBloc>().add(
                              PaymentFetchEvent(),
                            ));
                  }
                  if (state is PaymentLoading) {
                    return const Loader(
                      color: AppPallete.blackColor,
                    );
                  }
                  if (state is PaymentSuccess) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: RadioButtonList(
                              costs: widget.costs,
                              onSelect: _setSelectedMethod,
                              methods: state.methods,
                              selectedValue: _selectedMethodId,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppButton(
                              onPressed: () {
                                // widget.navigateTo(1);
                                if (_selectedMethodId == 0) {
                                  showSnackBar(
                                    context,
                                    "الرجاء إختيار طريقة الدفع اولاً",
                                  );
                                  return;
                                }

                                if (_getCost(widget.costs, _selectedMethodId,
                                        isLibyana(context)) ==
                                    null) {
                                  showSnackBar(context,
                                      "عفواً الإشتراك في هذه الباقة بطريقة الدفع المختارة غير متوفرة حالياً");
                                }
                                var cost = widget.costs
                                    .where((element) =>
                                        element.paymentMethodId ==
                                        _selectedMethodId)
                                    .first;
                                if (cost.payment.contains("Wallet")) {
                                  showModalBottomSheet(
                                    isScrollControlled: false,
                                    context: context,
                                    backgroundColor: AppPallete.whiteColor,
                                    showDragHandle: true,
                                    builder: (context) {
                                      return VerifySubscriptionPage(
                                        cost: widget.costs
                                            .where((element) =>
                                                element.paymentMethodId ==
                                                _selectedMethodId)
                                            .first,
                                        navigateTo: widget.navigateTo,
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      WebViewExample.route(
                                          token: token,
                                          costId: cost.subscriptionCostId));
                                }
                              },
                              text: "أختيار",
                              height: 60,
                              color: AppPallete.blackColor,
                              borderColor: AppPallete.transparentColor,
                              opicity: 1,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                })
          ]),
        ),
      ),
    );
  }
}

class RadioButtonList extends StatelessWidget {
  final List<SubscriptionCostModel> costs;
  final List<PaymentMethodModel> methods;
  final Function(int? value) onSelect;
  final int? selectedValue;

  RadioButtonList(
      {super.key,
      required this.costs,
      required this.onSelect,
      required this.methods,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        log("methods.length : " + methods.length.toString());
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFECECEC), width: 1)),
          child: ListTile(
            trailing: Radio<int>(
              value: methods[index].paymentMethodId,
              groupValue: selectedValue,
              activeColor: AppPallete.primaryColor,
              onChanged: (int? value) {
                onSelect(value);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  methods[index].methodName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppPallete.blackColor,
                  ),
                ),
                Text(
                  _getCost(costs, methods[index].paymentMethodId,
                              isLibyana(context)) !=
                          null
                      ? '${_getCost(costs, methods[index].paymentMethodId, isLibyana(context))!.cost} د.ل'
                      : '#',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppPallete.blackColor,
                  ),
                ),
              ],
            ),
            // leading: Image.asset(AppImages.walletSelected),
          ),
        );
      },
      itemCount: methods.length,
    );
  }

  // String _getCost(List<SubscriptionCostModel> costs, int paymentId) {
  //   String value = "";
  //   value = costs
  //           .firstWhereOrNull((element) => element.paymentMethodId == paymentId)
  //           ?.cost ??
  //       "";
  //   return value + "د.ل";
  // }
}

SubscriptionCostModel? _getCost(
    List<SubscriptionCostModel> costs, int paymentId, String isLibyana) {
  // return costs.firstWhereOrNull((element) =>
  //     element.paymentMethodId == paymentId && element.payment == 'Wallet');

  for (var element in costs) {
    if (element.paymentMethodId == paymentId &&
        element.systemCarrier == 'None') {
      return element;
    }
    if (element.paymentMethodId == paymentId &&
        element.systemCarrier == isLibyana) {
      return element;
    }
  }
  return null;
}

String isLibyana(BuildContext context) {
  return ((context.read<AppUserCubit>().state as AppUserLoggedIn)
          .user
          .phoneNumber
          .contains('21892'))
      ? 'Libyana'
      : 'Madar';
}
