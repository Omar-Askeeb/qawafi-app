import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/usecases/my_subscription.dart';
import 'package:qawafi_app/features/subscription/data/models/subscription_period_model.dart';
import 'package:qawafi_app/features/subscription/domain/usecases/fetch_subscription_cost.dart';
import 'package:qawafi_app/features/subscription/domain/usecases/fetch_subscription_period.dart';

import '../../../data/models/subscription_cost_model.dart';

part 'subscription_management_event.dart';
part 'subscription_management_state.dart';

class SubscriptionManagementBloc
    extends Bloc<SubscriptionManagementEvent, SubscriptionManagementState> {
  final FetchSubscriptionCost _fetchSubscriptionCost;
  final FetchSubscriptionPeriod _fetchSubscriptionPeriod;
  final MySubscription _mySubscription;
  final AppUserCubit _appUserCubit;
  final LocalStorage _localStorage;
  final AppUserSubscriptionCubit _appUserSubscriptionCubit;
  SubscriptionManagementBloc({
    required FetchSubscriptionCost fetchSubscriptionCost,
    required FetchSubscriptionPeriod fetchSubscriptionPeriod,
    required MySubscription mySubscription,
    required AppUserCubit appUserCubit,
    required LocalStorage localStorage,
    required AppUserSubscriptionCubit appUserSubscriptionCubit,
  })  : _fetchSubscriptionCost = fetchSubscriptionCost,
        _fetchSubscriptionPeriod = fetchSubscriptionPeriod,
        _mySubscription = mySubscription,
        _appUserCubit = appUserCubit,
        _localStorage = localStorage,
        _appUserSubscriptionCubit = appUserSubscriptionCubit,
        super(SubscriptionManagementInitial()) {
    on<SubscriptionManagementFetch>(_onSubscriptionManagementFetch);
  }

  _onSubscriptionManagementFetch(
      SubscriptionManagementFetch event, emit) async {
    emit(SubscriptionManagementLoading());
    bool hasErrorOccurred = false;
    var periodsRes = await _fetchSubscriptionPeriod(NoParams());
    List<SubscriptionPeriodModel> periods = [];
    List<SubscriptionCostModel> costs = [];

    var costsRes = await _fetchSubscriptionCost(FetchSubscriptionCostParams());
    if (_appUserCubit.state is AppUserLoggedIn &&
        (_appUserCubit.state as AppUserLoggedIn).user.customerType ==
            'Subscriber') {
      var subRes = await _mySubscription(StringParam(
          string: (_appUserCubit.state as AppUserLoggedIn).user.id));

      subRes.fold(
        (l) {
          _localStorage.storeMySubscription('');
          _appUserSubscriptionCubit.update(null);
        },
        (r) {
          _localStorage.storeMySubscription(
            jsonEncode(
              r.toJson(),
            ),
          );
          _appUserSubscriptionCubit.update(r);
        },
      );
    } else {
      _localStorage.storeMySubscription('');
      _appUserSubscriptionCubit.update(null);
    }
    periodsRes.fold((l) {
      emit(
        SubscriptionManagementFailure(
          message: l.message,
        ),
      );
      hasErrorOccurred = true;
    }, (r) => periods = r);

    costsRes.fold((l) {
      emit(
        SubscriptionManagementFailure(
          message: l.message,
        ),
      );
      hasErrorOccurred = true;
    }, (r) => costs = r);
 
       log('XX : ' + costs.toString());

    String carrier = 'libyana';
    if (_appUserCubit.state is AppUserLoggedIn) {
      final phone = (_appUserCubit.state as AppUserLoggedIn).user.phoneNumber;
      if (phone.contains('21892') || phone.contains('21894')) {
        carrier = 'libyana';
      } else {
        carrier = 'madar';
      }
    }

    costs = costs
        .where((c) => c.systemCarrier.toLowerCase() == carrier)
        .toList();
      log('XX : ' + costs.toString());
    periods = periods.map((period) {
      final updatedPeriod = period.copyWith(
        subscriptionCosts: costs
            .where((element) =>
                period.subscriptionPeriodId == element.subscriptionPeriodId)
            .toList(),
      );

      log('${updatedPeriod.subscriptionPeriodId} ADDED');
      return updatedPeriod;
    }).toList();

    if (!hasErrorOccurred) {
      periods.forEach((element) {
        log(element.toJson().toString());
      });
      emit(SubscriptionManagementSucess(bunches: periods));
    }
  }
}
