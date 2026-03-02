import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/common/entities/user.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/features/customer/domain/usecases/update_user_info.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UpdateUserInfo _updateUserInfo;
  final AppUserCubit _appUserCubit;
  final LocalStorage _localStorage;
  UserInfoBloc({
    required UpdateUserInfo updateUserInfo,
    required AppUserCubit appUserCubit,
    required LocalStorage localStorage,
  })  : _updateUserInfo = updateUserInfo,
        _appUserCubit = appUserCubit,
        _localStorage = localStorage,
        super(UserInfoInitial()) {
    on<UserInfoUpdateEvent>(_onUserInfoUpdateEvent);
  }

  _onUserInfoUpdateEvent(UserInfoUpdateEvent event, emit) async {
    emit(UserInfoLoading());

    var res = await _updateUserInfo(
      UpdateUserInfoParams(
        userId: event.userId,
        name: event.name,
      ),
    );

    res.fold(
      (l) => emit(UserInfoFailure(message: l.message)),
      (r) => _emitAuthSuccess(
          User(
              fullName: r.fullName,
              note: r.note,
              balance: r.balance,
              customerType: r.customerType,
              id: r.userId,
              phoneNumber: r.phoneNumber,
              name: r.fullName),
          emit),

      // {
      //   _appUserCubit.updateUser(
      //   User(
      //       fullName: r.fullName,
      //       note: r.note,
      //       balance: r.balance,
      //       customerType: r.customerType,
      //       id: r.userId,
      //       phoneNumber: r.phoneNumber,
      //       name: r.fullName),
      // );
      //   emit(UserInfoSuccess());
      // },
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<UserInfoState> emit,
  ) {
    _localStorage.storeUser(jsonEncode(user.toJson()));
    _appUserCubit.updateUser(user);
    emit(
      UserInfoSuccess(),
    );
  }
}
