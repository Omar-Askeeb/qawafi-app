import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/features/customer/domain/usecases/cancel_subscription.dart';
import 'package:qawafi_app/features/customer/domain/usecases/subscribe.dart';

import '../../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../../core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import '../../../../../core/common/entities/user.dart';
import '../../../../../core/usecase/string_param.dart';
import '../../../../customer/domain/usecases/my_subscription.dart';

part 'verify_subscription_event.dart';
part 'verify_subscription_state.dart';

class VerifySubscriptionBloc
    extends Bloc<VerifySubscriptionEvent, VerifySubscriptionState> {
  final Subscribe _subscribe;
  final AppUserCubit _appUserCubit;
  final MySubscription _mySubscription;
  final AppUserSubscriptionCubit _appUserSubscriptionCubit;
  final CancelSubscription _cancelSubscription;
  final LocalStorage _localStorage;

  VerifySubscriptionBloc({
    required Subscribe subscribe,
    required AppUserCubit appUserCubit,
    required AppUserSubscriptionCubit appUserSubscriptionCubit,
    required MySubscription mySubscription,
    required CancelSubscription cancelSubscription,
    required LocalStorage localStorage,
  })  : _subscribe = subscribe,
        _appUserCubit = appUserCubit,
        _appUserSubscriptionCubit = appUserSubscriptionCubit,
        _mySubscription = mySubscription,
        _cancelSubscription = cancelSubscription,
        _localStorage = localStorage,
        super(VerifySubscriptionInitial()) {
    on<VerifySubscriptionWalletSubscribeEvent>(
        _onVerifySubscriptionWalletSubscribeEvent);
    on<VerifySubscriptionCancelEvent>(_onVerifySubscriptionCancelEvent);
  }

  _onVerifySubscriptionWalletSubscribeEvent(
      VerifySubscriptionWalletSubscribeEvent event, emit) async {
    emit(VerifySubscriptionLoading());
    if (_appUserCubit.state is! AppUserLoggedIn) {
      emit(
        VerifySubscriptionFailure(
          message: "لست مستخدم الرجاء تسجيل الدخول أولاً",
        ),
      );
    }

    var res = await _subscribe(
      SubscribeParams(
        userId: (_appUserCubit.state as AppUserLoggedIn).user.id,
        subscriptionId: event.subscriptionCostId,
      ),
    );
    String userId = '';
    res.fold(
        (l) => emit(
              VerifySubscriptionFailure(
                message: l.message,
              ),
            ), (r) {
      userId = r.userId;
      _emitAuthSuccess(
          User(
            id: r.userId,
            phoneNumber: r.phoneNumber,
            name: r.fullName,
            balance: r.balance,
            customerType: r.customerType,
            fullName: r.fullName,
            note: r.note,
          ),
          emit);
    });

    if (userId.isNotEmpty) {
      var subRes = await _mySubscription(
        StringParam(string: userId),
      );

      subRes.fold(
        (l) => null,
        (r) {
          _appUserSubscriptionCubit.update(r);
        },
      );
    }
  }

  _onVerifySubscriptionCancelEvent(
      VerifySubscriptionCancelEvent event, emit) async {
    emit(VerifySubscriptionLoading());
    if (_appUserCubit.state is AppUserLoggedIn) {
      try {
        var res = await _cancelSubscription(StringParam(
            string: (_appUserCubit.state as AppUserLoggedIn).user.id));
        res.fold(
            (l) => emit(
                  VerifySubscriptionFailure(message: l.message),
                ), (r) {
          _localStorage.storeMySubscription(jsonEncode(r.toJson()));
          _appUserSubscriptionCubit.update(r);
          emit(VerifySubscriptionSuccess());
        });
      } catch (e) {
        emit(
          VerifySubscriptionFailure(message: "مشكلة غير متوقعة"),
        );
      }
    }
  }

  void _emitAuthSuccess(
    User user,
    Emitter<VerifySubscriptionState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(VerifySubscriptionSuccess());
  }
}
