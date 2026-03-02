import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/customer/domain/usecases/charge_wallet.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final ChargeWallet _chargeWallet;
  final AppUserCubit _appUserCubit;

  WalletBloc({
    required ChargeWallet chargeWallet,
    required AppUserCubit appUserCubit,
  })  : _chargeWallet = chargeWallet,
        _appUserCubit = appUserCubit,
        super(WalletInitial()) {
    on<WalletChargeEvent>(_onWalletChargeEvent);
  }

  _onWalletChargeEvent(WalletChargeEvent event, emit) async {
    emit(WalletLoading());
    if (_appUserCubit.state is! AppUserLoggedIn) {
      emit(
        WalletFailure(
          message: "لست مستخدم الرجاء تسجيل الدخول أولاً",
        ),
      );
    }

    var res = await _chargeWallet(
      ChargeWalletParams(
        userId: (_appUserCubit.state as AppUserLoggedIn).user.id,
        cardNo: event.cardNo,
      ),
    );

    res.fold(
      (l) => emit(
        WalletFailure(
          message: l.message,
        ),
      ),
      (r) => _emitAuthSuccess(
          User(
            id: r.userId,
            phoneNumber: r.phoneNumber,
            name: r.fullName,
            balance: r.balance,
            customerType: r.customerType,
            fullName: r.fullName,
            note: r.note,
          ),
          emit),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<WalletState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(WalletSuccess());
  }
}
