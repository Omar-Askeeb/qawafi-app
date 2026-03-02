import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/usecases/fetch_spoken_proverbs_category.dart';

part 'spoken_proverb_category_event.dart';
part 'spoken_proverb_category_state.dart';

class SpokenProverbCategoryBloc
    extends Bloc<SpokenProverbCategoryEvent, SpokenProverbCategoryState> {
  final FetchSpokenProverbCategories _fetchSpokenProverbCategories;
  SpokenProverbCategoryBloc({
    required FetchSpokenProverbCategories fetchSpokenProverbCategories,
  })  : _fetchSpokenProverbCategories = fetchSpokenProverbCategories,
        super(SpokenProverbCategoryInitial()) {
    on<SpokenProverbCategoryFetchEvent>(_onSpokenProverbCategoryFetchEvent);
  }

  _onSpokenProverbCategoryFetchEvent(
      SpokenProverbCategoryFetchEvent event, emit) async {
    emit(SpokenProverbCategoryLoading());

    var res = await _fetchSpokenProverbCategories(NoParams());

    res.fold(
      (l) => emit(
        SpokenProverbCategoryFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        SpokenProverbCategoryLoaded(categories: r),
      ),
    );
  }
}
