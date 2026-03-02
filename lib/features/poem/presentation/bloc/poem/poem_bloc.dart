import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';

import 'package:qawafi_app/features/poem/domain/usecases/get_poem_by_category_melody.dart';
import 'package:qawafi_app/features/poem/domain/usecases/get_poem_by_purpose_category.dart';
import 'package:qawafi_app/features/purpose/domain/entites/purpose.dart';

part 'poem_event.dart';
part 'poem_state.dart';

class PoemBloc extends Bloc<PoemEvent, PoemState> {
  final GetPoemByPurposeAndCategory _getPoemByPurposeAndCategory;
  final GetPoemByCategoryAndMelody _getPoemByCategoryAndMelody;

  PoemBloc({
    required GetPoemByPurposeAndCategory getPoemByPurposeAndCategory,
    required GetPoemByCategoryAndMelody getPoemByCategoryAndMelody,
  })  : _getPoemByPurposeAndCategory = getPoemByPurposeAndCategory,
        _getPoemByCategoryAndMelody = getPoemByCategoryAndMelody,
        super(PoemInitial()) {
    on<PoemGetByPurposeAndCategory>(_getByPurposeAndCategory);
    on<PoemGetByCategoryAndMelody>(_getByCategoryAndMelody);
  }

  _getByPurposeAndCategory(PoemGetByPurposeAndCategory event, emit) async {
    // TODO: implement event handler
    if (event.pageNo == 1) emit(PoemLoading());
    PoemDataModel? oldPoems;
    if (_hasReachedMax(state) && event.pageNo != 1) {
      return;
    } else if (state is PoemSuccess) {
      // state is PoemSuccess && state.poemDataModel ?

      oldPoems = _getPoems(state);
    }

    final res = await _getPoemByPurposeAndCategory(
      GetPoemByPurposeAndCategoryParam(
        purpose: event.purpose.purposeId,
        poemCategory: event.category,
        pageNo: event.pageNo,
        pageSize: event.pageSize,
      ),
    );

    res.fold((l) => emit(PoemFailure(message: l.message)), (r) {
      oldPoems != null ? oldPoems!.poems.addAll(r.poems) : oldPoems = r;
      emit(
        PoemSuccess(
          poemDataModel: oldPoems!,
          purpose: event.purpose.purposeName,
          category: event.category == 'Recite' ? 0 : 1,
        ),
      );
    });
  }

  _getByCategoryAndMelody(PoemGetByCategoryAndMelody event, emit) async {
    emit(PoemLoading());
    final res = await _getPoemByCategoryAndMelody(
      GetPoemByCategoryAndMelodyParam(
        poemCategory: event.category,
        melody: event.melody,
      ),
    );

    res.fold(
      (l) => emit(
        PoemFailure(message: l.message),
      ),
      (r) => emit(
        PoemSuccess(
            poemDataModel: r,
            purpose: '',
            category: event.category == 'Recite' ? 0 : 1),
      ),
    );
  }

  bool _hasReachedMax(PoemState state) =>
      state is PoemSuccess && state.hasReachedMax;

  PoemDataModel? _getPoems(PoemState state) {
    if (state is PoemSuccess) {
      return state.poemDataModel;
    }
    return null;
  }
}
