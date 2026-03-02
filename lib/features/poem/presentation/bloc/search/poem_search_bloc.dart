import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/enums/search_keys.dart';

import '../../../data/models/poem_data_model.dart';
import '../../../domain/usecases/search_poems.dart';

part 'poem_search_event.dart';
part 'poem_search_state.dart';

class PoemSearchBloc extends Bloc<PoemSearchEvent, PoemSearchState> {
  final SearchPoems _searchPoems;
  PoemSearchBloc({required SearchPoems searchPoems})
      : _searchPoems = searchPoems,
        super(PoemSearchInitial()) {
    on<PerformSearch>(_onPerformSearch);
  }

  _onPerformSearch(PerformSearch event, emit) async {
    if (event.pageNo == 1) emit(PoemSearchLoading());
    PoemDataModel? oldPoems;

    if (event.query.isEmpty) {
      emit(PoemSearchEmpty());
      return;
    }

    if (_hasReachedMax(state) && event.pageNo != 1) {
      return;
    } else if (state is PoemSearchSuccess) {
      // state is PoemSuccess && state.poemDataModel ?

      oldPoems = _getPoems(state);
    }

    final res = await _searchPoems(
      SearchPoemsParams(
        searchKeys: event.searchKeys,
        searchValue: event.query,
        pageNo: event.pageNo,
        pageSize: event.pageSize,
      ),
    );

    res.fold((l) => emit(PoemSearchFailure(message: l.message)), (r) {
      oldPoems != null ? oldPoems!.poems.addAll(r.poems) : oldPoems = r;
      emit(PoemSearchSuccess(
        PoemSearchResults: oldPoems!,
        hasReachedMax: r.poems.isEmpty,
      ));
    });
  }

  bool _hasReachedMax(PoemSearchState state) =>
      state is PoemSearchSuccess && state.hasReachedMax;

  PoemDataModel? _getPoems(PoemSearchState state) {
    if (state is PoemSearchSuccess) {
      return state.PoemSearchResults;
    }
    return null;
  }
}
