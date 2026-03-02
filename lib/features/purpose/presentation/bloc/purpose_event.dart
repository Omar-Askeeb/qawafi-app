part of 'purpose_bloc.dart';

@immutable
sealed class PurposeEvent {}

final class PurposeFetchAll extends PurposeEvent {
  PurposeFetchAll();
}
