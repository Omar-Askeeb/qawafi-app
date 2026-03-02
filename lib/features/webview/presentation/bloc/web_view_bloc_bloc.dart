import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/auth/domain/usecases/refresh_token.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/localStorage/loacal_storage.dart';
import '../../../../core/usecase/string_param.dart';
import '../../../customer/domain/usecases/my_subscription.dart';

part 'web_view_bloc_event.dart';
part 'web_view_bloc_state.dart';

class WebViewBlocBloc extends Bloc<WebViewBlocEvent, WebViewBlocState> {
  final RefreshToken _refreshToken;
  final AppUserCubit _appUserCubit;
  final MySubscription _mySubscription;
  final AppUserSubscriptionCubit _appUserSubscriptionCubit;
  final LocalStorage _localStorage;
  WebViewBlocBloc({
    required RefreshToken refreshToken,
    required AppUserCubit appUserCubit,
    required AppUserSubscriptionCubit appUserSubscriptionCubit,
    required MySubscription mySubscription,
    required LocalStorage localStorage,
  })  : _refreshToken = refreshToken,
        _appUserCubit = appUserCubit,
        _appUserSubscriptionCubit = appUserSubscriptionCubit,
        _mySubscription = mySubscription,
        _localStorage = localStorage,
        super(WebViewBlocInitial()) {
    on<WebViewBlocSubDoneEvent>(_onWebViewBlocSubDoneEvent);
  }

  _onWebViewBlocSubDoneEvent(WebViewBlocSubDoneEvent event, emit) async {
    // TODO: implement event handler
    emit(WebViewBlocLoading());
    var res = await _refreshToken(
      RereshTokenParams(token: await _localStorage.refreshToken),
    );
    res.fold(
      (l) => emit(WebViewBlocFailure(message: l.message)),
      (r) {
        User user = User(
          id: r.userId,
          phoneNumber: r.phoneNumber,
          name: r.fullName,
          balance: r.balance,
          customerType: r.customerType,
          fullName: r.fullName,
          note: r.note,
        );
        _localStorage.storeUserData(jsonEncode(user.toJson()));
        _localStorage.storeUser(jsonEncode(user.toJson()));
        _appUserCubit.updateUser(user);
      },
    );

    var res2 = await _mySubscription(
        StringParam(string: (_appUserCubit.state as AppUserLoggedIn).user.id));

    res2.fold(
      (l) => emit(WebViewBlocFailure(message: l.message)),
      (r) {
        _localStorage.storeMySubscription(jsonEncode(r.toJson()));
        _appUserSubscriptionCubit.update(r);
        emit(
          WebViewBlocLoaded(message: "تم الإشتراك بنجاح"),
        );
      },
    );
    emit(WebViewBlocLoaded);
  }
}
