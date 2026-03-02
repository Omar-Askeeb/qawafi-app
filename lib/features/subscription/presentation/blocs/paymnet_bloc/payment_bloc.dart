import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/subscription/data/models/payment_method_model.dart';
import 'package:qawafi_app/features/subscription/domain/usecases/fetch_payment_methods.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final FetchPaymentMethods _fetchPaymentMethods;
  PaymentBloc({required FetchPaymentMethods fetchPaymentMethods})
      : _fetchPaymentMethods = fetchPaymentMethods,
        super(PaymentInitial()) {
    on<PaymentFetchEvent>(_onPaymentFetchEvent);
  }

  _onPaymentFetchEvent(PaymentFetchEvent event, emit) async {
    emit(PaymentLoading());
    var res = await _fetchPaymentMethods(NoParams());

    res.fold(
      (l) => emit(PaymentFailure(
        message: l.message,
      )),
      (r) => emit(
        PaymentSuccess(methods: r),
      ),
    );
  }
}
