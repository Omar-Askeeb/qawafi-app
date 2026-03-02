import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/ads/domain/usecases/fetch_advertisement.dart';

import '../../data/models/advertisement_model.dart';

part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  final FetchAdvertisement _fetchAdvertisement;
  AdvertisementBloc({required FetchAdvertisement fetchAdvertisement})
      : _fetchAdvertisement = fetchAdvertisement,
        super(AdvertisementInitial()) {
    on<AdvertisementFetch>(_onAdvertisementFetch);
  }

  _onAdvertisementFetch(AdvertisementFetch event, emit) async {
    emit(AdvertisementLoading());
    var res = await _fetchAdvertisement(NoParams());

    res.fold(
      (l) => emit(
        AdvertisementFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        AdvertisementSuccess(
          ads: r,
        ),
      ),
    );
  }
}
