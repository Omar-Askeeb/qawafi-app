import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../features/customer/domain/entites/subscription.dart';

part 'app_user_subscription_state.dart';

class AppUserSubscriptionCubit extends Cubit<AppUserSubscriptionState> {
  AppUserSubscriptionCubit() : super(AppUserSubscriptionInitial());

  void update(Subscription? subscription) {
    if (subscription == null) {
      emit(AppUserSubscriptionInitial());
    } else {
      emit(AppUserSubscriptionSubscribed(subscription: subscription));
    }
  }
}
