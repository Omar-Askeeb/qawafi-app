part of 'melody_bloc.dart';

@immutable
sealed class MelodyState {}

final class MelodyInitial extends MelodyState {}

final class MelodyLoading extends MelodyState {}

final class MelodyFailuer extends MelodyState {
  final String message;

  MelodyFailuer(this.message);
}

final class MelodySuccess extends MelodyState {
  final List<Melody> melodies;

  MelodySuccess({required this.melodies});
}
