import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../customer/domain/usecases/change_password.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword _changePassword;

  ChangePasswordBloc({required ChangePassword changePassword})
      : _changePassword = changePassword,
        super(ChangePasswordInitial()) {
    on<ChangePasswordDoEvent>(_onChangePasswordDoEvent);
  }

  _onChangePasswordDoEvent(ChangePasswordDoEvent event, emit) async {
    emit(ChangePasswordLoading());

    var res = await _changePassword(ChangePasswordParams(
        password: event.password, newPassword: event.newPassword));

    res.fold(
      (l) => emit(
        ChangePasswordFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        ChangePasswordSuccess(message: r),
      ),
    );
  }
}
