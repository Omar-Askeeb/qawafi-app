part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashBDone extends SplashState {}

final class SplashCheckFirstTime extends SplashState {
  final UserState userState;

  SplashCheckFirstTime({required this.userState});
}
