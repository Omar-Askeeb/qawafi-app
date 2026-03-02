import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';

import '../../data/models/reel_model.dart';
import '../../domain/usecases/fetch_reels.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final FetchReels _fetchReels;
  ReelsBloc({required FetchReels fetchReels})
      : _fetchReels = fetchReels,
        super(ReelsInitial()) {
    on<FetchReelsEvent>(_onFetchReelsEvent);
  }

  _onFetchReelsEvent(FetchReelsEvent event, emit) async {
    emit(ReelsLoading());
    var res = await _fetchReels(NoParams());

    res.fold(
      (l) => emit(
        ReelsFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        ReelsSuccess(
          reels: r,
        ),
      ),
    );
  }
}
