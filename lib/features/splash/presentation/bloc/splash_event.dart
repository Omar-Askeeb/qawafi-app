part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}

final class SplashIsFirstTime extends SplashEvent {}

final class SplashCheck extends SplashEvent {}
