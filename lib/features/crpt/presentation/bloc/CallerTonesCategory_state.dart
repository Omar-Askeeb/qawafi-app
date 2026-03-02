part of 'CallerTonesCategory_bloc.dart';

@immutable
abstract class CallerTonesCategoryState {
}

class CallerTonesCategoryInitial extends CallerTonesCategoryState {}

class CallerTonesCategoryLoading extends CallerTonesCategoryState {}

class CallerTonesCategoryLoaded extends CallerTonesCategoryState {
  final List<CallerTonesCategory> callerTonesCategory;

   CallerTonesCategoryLoaded({required this.callerTonesCategory});
}

class CallerTonesCategoryFailure extends CallerTonesCategoryState {
  final String message;

   CallerTonesCategoryFailure({required this.message});
}