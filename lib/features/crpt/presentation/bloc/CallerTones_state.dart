part of 'CallerTones_bloc.dart';

@immutable
abstract class CallerTonesState {}

class CallerTonesInitial extends CallerTonesState {}

class CallerTonesLoading extends CallerTonesState {}

class CallerTonesLoaded extends CallerTonesState {
  final List<CallerTone> callerTones;

   CallerTonesLoaded({required this.callerTones});


}

class CallerTonesFailure extends CallerTonesState {
  final String message;

   CallerTonesFailure({required this.message});
}