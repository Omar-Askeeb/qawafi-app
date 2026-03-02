import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/popularProverbs/domain/entites/popularProverbs.dart';
import 'package:qawafi_app/features/popularProverbs/domain/usecases/get_proverbsByAlpha.dart';

part 'popularProverbs_state.dart';
part 'popularProverbs_event.dart';

class PopularProverbsBloc extends Bloc<PopularProverbsEvent, PopularProverbsState> {
  final GetProverbsbyalpha _getProverbsbyalpha;
  PopularProverbsBloc({required GetProverbsbyalpha getPopularProverbs})
      : _getProverbsbyalpha = getPopularProverbs,
        super(PopularProverbsInitial()) {
    on<PopularProverbsEvent>(
      (event, emit) async {
        if (event is GetPopularProverbsByAlpha) {
          emit(PopularProverbsLoading());
          final res = await _getProverbsbyalpha.call(
            ProverbsParam(alpha: event.Alpha),
          );
          emit(_mapRes(res));
        } else if (event is RefreshPopularProverbsByAlbpa) {
          emit(PopularProverbsLoading());
          final res = await _getProverbsbyalpha.call(
            ProverbsParam(alpha: event.Alpha),
          );
          emit(_mapRes(res));
        }
      },
    );
  }

  PopularProverbsState _mapRes(Either<Failure, List<PopularProverbs>> res) {
    return res.fold(
      (l) => PopularProverbsFailure(message: l.message),
      (r) => PopularProverbsLoaded(popularProverbs: r),
    );
  }
}
