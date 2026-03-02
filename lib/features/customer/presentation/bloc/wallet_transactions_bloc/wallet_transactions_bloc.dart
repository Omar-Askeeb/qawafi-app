import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/features/customer/data/models/wallet_transaction_model.dart';

import '../../../domain/usecases/fetch_wallet_transactions.dart';

part 'wallet_transactions_event.dart';
part 'wallet_transactions_state.dart';

class WalletTransactionsBloc
    extends Bloc<WalletTransactionsEvent, WalletTransactionsState> {
  final FetchWalletTransactions _fetchWalletTransactions;
  final AppUserCubit _appUserCubit;

  WalletTransactionsBloc({
    required FetchWalletTransactions fetchWalletTransactions,
    required AppUserCubit appUserCubit,
  })  : _fetchWalletTransactions = fetchWalletTransactions,
        _appUserCubit = appUserCubit,
        super(WalletTransactionsInitial()) {
    on<WalletTransactionsFetchEvent>(_onWalletTransactionsFetchEvent);
  }

  _onWalletTransactionsFetchEvent(
      WalletTransactionsFetchEvent event, emit) async {
    emit(WalletTransactionsLoading());
    if (_appUserCubit.state is! AppUserLoggedIn) {
      emit(WalletTransactionsFailure(message: "الرجاء التسجيل أولاً"));
      return;
    }
    var res = await _fetchWalletTransactions(
        StringParam(string: (_appUserCubit.state as AppUserLoggedIn).user.id));

    res.fold(
      (l) => emit(
        WalletTransactionsFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        WalletTransactionsLoaded(
          transactions: r,
        ),
      ),
    );
  }
}
