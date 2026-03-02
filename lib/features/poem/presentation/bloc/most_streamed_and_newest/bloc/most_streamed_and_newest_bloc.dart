import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/usecase/usecase.dart';
import '../../../../data/models/poem_data_model.dart';
import '../../../../domain/usecases/get_most_streamed.dart';
import '../../../../domain/usecases/get_newest.dart';

part 'most_streamed_and_newest_event.dart';
part 'most_streamed_and_newest_state.dart';

class MostStreamedAndNewestBloc
    extends Bloc<MostStreamedAndNewestEvent, MostStreamedAndNewestState> {
  final GetMostStreamed _getMostStreamed;
  final GetNewest _getNewest;
  MostStreamedAndNewestBloc({
    required GetMostStreamed getMostStreamed,
    required GetNewest getNewest,
  })  : _getMostStreamed = getMostStreamed,
        _getNewest = getNewest,
        super(MostStreamedAndNewestInitial()) {
    on<FetchMostStreamedAndNewest>(_onFetchMostStreamedAndNewest);
  }

  _onFetchMostStreamedAndNewest(event, emit) async {
    emit(MostStreamedAndNewestLoading());
    final res = await _getMostStreamed(NoParams());

    final res2 = await _getNewest(NoParams());
    PoemDataModel? mostStreamed;
    PoemDataModel? newest;
    res.fold(
      (l) => emit(
        MostStreamedAndNewestFailure(message: l.message),
      ),
      (r) => mostStreamed = r,
    );
    res2.fold(
      (l) => emit(
        MostStreamedAndNewestFailure(message: l.message),
      ),
      (r) => newest = r,
    );

    if (newest != null && mostStreamed != null) {
      emit(
        MostStreamedAndNewestSuccess(
          mostStreamed: mostStreamed!,
          newest: newest!,
        ),
      );
    }
  }
}
