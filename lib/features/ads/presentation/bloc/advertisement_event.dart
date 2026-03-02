part of 'advertisement_bloc.dart';

@immutable
sealed class AdvertisementEvent {}

final class AdvertisementFetch extends AdvertisementEvent {}
