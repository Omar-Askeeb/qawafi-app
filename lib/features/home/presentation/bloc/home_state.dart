part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});
}

final class HomeLoaded extends HomeState {
  final List<PoetModel> poets;
  final PoemDataModel poems;

  HomeLoaded({required this.poets, required this.poems});
}
