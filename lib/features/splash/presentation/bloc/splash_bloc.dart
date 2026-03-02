import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/enums/user_state.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LocalStorage _localStorage;
  final AppUserCubit _appUserCubit;

  SplashBloc(
      {required LocalStorage localStorage, required AppUserCubit appUserCubit})
      : _localStorage = localStorage,
        _appUserCubit = appUserCubit,
        super(SplashInitial()) {
    on<SplashIsFirstTime>(_onSplashIsFirstTime);

    on<SplashCheck>(_onSplashCheck);
  }

  _onSplashIsFirstTime(event, emit) async {
    // TODO: implement event handler
    await _localStorage.storeIsFirstTime('false');
    emit(SplashBDone());
  }

  _onSplashCheck(event, emit) async {
    bool isFirstTime = (await _localStorage.isFirstTime);
    UserState userState = isFirstTime ? UserState.FirstTime : UserState.Guest;
    if (_appUserCubit.state is AppUserLoggedIn) {
      userState = UserState.Logged;
    }
    emit(SplashCheckFirstTime(userState: userState));
  }
}
