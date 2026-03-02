import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user_subscription/cubit/app_user_subscription_cubit.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/utils/get_device_id.dart';
import 'package:qawafi_app/features/auth/domain/usecases/request_otp.dart';
import 'package:qawafi_app/features/auth/domain/usecases/reset_password.dart';
import 'package:qawafi_app/features/auth/domain/usecases/signout.dart';
import 'package:qawafi_app/features/auth/domain/usecases/signup.dart';
import 'package:qawafi_app/features/customer/domain/usecases/my_subscription.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../domain/usecases/get_reset_password_token.dart';
import '../../domain/usecases/login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final RequestOtp _requestOtp;
  final SignUp _signUp;
  final ResetPassword _resetPassword;
  final GetResetPasswordToken _getResetPasswordToken;
  final LocalStorage _localStorage;
  final MySubscription _mySubscription;
  final ResetDeviceId _resetDeviceId;
  final AppUserSubscriptionCubit _appUserSubscriptionCubit;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required Login login,
      required RequestOtp requestOtp,
      required SignUp signUp,
      required GetResetPasswordToken getResetPasswordToken,
      required ResetPassword resetPassword,
      required AppUserCubit appUserCubit,
      required LocalStorage localStorage,
      required ResetDeviceId resetDeviceId,
      required AppUserSubscriptionCubit appUserSubscriptionCubit,
      required MySubscription mySubscription})
      : _login = login,
        _requestOtp = requestOtp,
        _signUp = signUp,
        _getResetPasswordToken = getResetPasswordToken,
        _resetPassword = resetPassword,
        _appUserCubit = appUserCubit,
        _localStorage = localStorage,
        _appUserSubscriptionCubit = appUserSubscriptionCubit,
        _mySubscription = mySubscription,
        _resetDeviceId = resetDeviceId,
        super(AuthInitial()) {
    on<AuthLogin>(_authLogin);
    on<AuthRequestOtp>(_authRequestOtp);
    on<AuthSignUp>(_authSignUp);
    on<AuthGetResetPasswordToken>(_authGetResetToken);
    on<ResetPasswordEvent>(_authResetPassword);
    on<AuthSignOut>(_onAuthSignOut);
  }

  _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String id = '';
      String userType = '';
      final res = await _login(
        LoginParam(
          phoneNumber: event.phoneNumber,
          password: event.password,
          deviceId: await getDeviceId() ?? 'UNKOWN',
        ),
      );
      res.fold(
        (l) => emit(
          AuthFailure(message: l.message),
        ),
        (r) {
          id = r.userInfo.userId;
          userType = r.userInfo.customerType;

          _emitAuthSuccess(
              User(
                id: r.userInfo.userId,
                phoneNumber: r.userInfo.phoneNumber,
                name: r.userInfo.fullName,
                balance: r.userInfo.balance,
                customerType: r.userInfo.customerType,
                fullName: r.userInfo.fullName,
                note: r.userInfo.note,
              ),
              emit);
          r.userInfo.userId;
        },
      );
      if (id.isNotEmpty) {
        var subRes = await _mySubscription(
          StringParam(string: id),
        );

        subRes.fold(
          (l) => null,
          (r) {
            _localStorage.storeMySubscription(
              jsonEncode(
                r.toJson(),
              ),
            );
            _appUserSubscriptionCubit.update(r);
          },
        );
        if (userType == 'Guest') {
          _localStorage.storeMySubscription('');
          _appUserSubscriptionCubit.update(null);
        }
      }
    } catch (e) {
      AuthFailure(message: e.toString());
    }
  }

  _authRequestOtp(event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _requestOtp.call(
      RequestOtpParams(
        phoneNumber: event.phoneNumber,
      ),
    );
    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) {
        if (!event.isResend) {
          emit(
            AuthOtpState(
              name: event.name,
              password: event.password,
              phoneNumber: event.phoneNumber,
            ),
          );
        } else {
          emit(AuthOtpSent());
        }
      },
    );
  }

  _authSignUp(event, emit) async {
    emit(AuthLoading());
    final res = await _signUp.call(
      SignUpParams(
        name: event.name,
        phoneNumber: event.phoneNumber,
        password: event.password,
        code: event.code,
        deviceId: await getDeviceId() ?? 'UNKOWN',
      ),
    );
    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) => _emitAuthSuccess(
          User(
            id: r.userInfo.userId,
            phoneNumber: r.userInfo.phoneNumber,
            name: r.userInfo.fullName,
            balance: r.userInfo.balance,
            customerType: r.userInfo.customerType,
            fullName: r.userInfo.fullName,
            note: r.userInfo.note,
          ),
          emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _localStorage.storeUser(jsonEncode(user.toJson()));
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(
        user: user,
      ),
    );
  }

  _authGetResetToken(AuthGetResetPasswordToken event, emit) async {
    emit(AuthLoading());
    final res = await _getResetPasswordToken.call(
      GetResetPassTokenParam(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) => emit(
        AuthResetPasswordTokenState(
          token: r,
          phoneNumber: event.phoneNumber,
        ),
      ),
    );
  }

  _authResetPassword(ResetPasswordEvent event, emit) async {
    emit(AuthLoading());
    final res = await _resetPassword.call(
      ResetPasswordParams(
        phoneNumber: event.phoneNumber,
        password: event.password,
        token: event.token,
      ),
    );

    res.fold(
      (l) => emit(
        AuthFailure(message: l.message),
      ),
      (r) => emit(
        AuthResuthPasswordSuccess(
          message: r,
        ),
      ),
    );
  }

  _onAuthSignOut(AuthSignOut event, emit) async {
    emit(AuthLoading());
    if (_appUserCubit.state is AppUserLoggedIn) {
      var res = await _resetDeviceId(StringParam(
          string: (_appUserCubit.state as AppUserLoggedIn).user.id));

      res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
        _localStorage.storeAccessToken('');
        _localStorage.storeRefreshToken('');
        _localStorage.storeUser('');
        _localStorage.storeUserData('');
        _appUserCubit.updateUser(null);
        _localStorage.storeMySubscription('');
        _appUserSubscriptionCubit.update(null);
        emit(AuthSignoutState());
      });
    }
    emit(AuthInitial());
  }
}
