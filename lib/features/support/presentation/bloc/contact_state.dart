part of 'contact_bloc.dart';

@immutable
sealed class ContactState {}

final class ContactInitial extends ContactState {}
final class ContactLoading extends ContactState {}
final class ContactFailure extends ContactState {final String message;

  ContactFailure({required this.message});}
final class ContactLoaded extends ContactState {}

