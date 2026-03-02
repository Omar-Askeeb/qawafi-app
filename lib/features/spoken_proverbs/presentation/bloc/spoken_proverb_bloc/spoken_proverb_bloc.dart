import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_model.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/usecases/fetch_spoken_proverbs_by_category.dart';

part 'spoken_proverb_event.dart';
part 'spoken_proverb_state.dart';

class SpokenProverbBloc extends Bloc<SpokenProverbEvent, SpokenProverbState> {
  final FetchSpokenProverbByCategory _fetchSpokenProverbByCategory;
  SpokenProverbBloc(
      {required FetchSpokenProverbByCategory fetchSpokenProverbByCategory})
      : _fetchSpokenProverbByCategory = fetchSpokenProverbByCategory,
        super(SpokenProverbInitial()) {
    on<SpokenProverbFetchEvent>(_onSpokenProverbFetchEvent);
  }

  _onSpokenProverbFetchEvent(SpokenProverbFetchEvent event, emit) async {
    emit(SpokenProverbLoading());

    var res = await _fetchSpokenProverbByCategory(
        StringParam(string: event.categoryId));

    res.fold(
      (l) => emit(
        SpokenProverbFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        SpokenProverbLoaded(spokenProverbs: r),
      ),
    );
  }
}
