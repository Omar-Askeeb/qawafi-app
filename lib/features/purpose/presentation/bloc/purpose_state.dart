part of 'purpose_bloc.dart';

@immutable
sealed class PurposeState {}

final class PurposeInitial extends PurposeState {}

final class PurposeLoading extends PurposeState {}

final class PurposeFailure extends PurposeState {
  final String message;

  PurposeFailure({required this.message});
}

final class PurposeSuccess extends PurposeState {
  final List<Purpose> purposes;

  PurposeSuccess({required this.purposes});
}
