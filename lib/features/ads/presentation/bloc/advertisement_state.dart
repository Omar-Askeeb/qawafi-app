part of 'advertisement_bloc.dart';

@immutable
sealed class AdvertisementState {}

final class AdvertisementInitial extends AdvertisementState {}

final class AdvertisementLoading extends AdvertisementState {}

final class AdvertisementFailure extends AdvertisementState {
  final String message;

  AdvertisementFailure({
    required this.message,
  });
}

final class AdvertisementSuccess extends AdvertisementState {
  final List<AdvertisementModel> ads;

  AdvertisementSuccess({
    required this.ads,
  });
}
