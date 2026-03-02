import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/search_pagination_params.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';
import 'package:qawafi_app/features/libyan_titles/domain/usecases/fetch_libyan_titles.dart';

part 'libyan_title_event.dart';
part 'libyan_title_state.dart';

class LibyanTitleBloc extends Bloc<LibyanTitleEvent, LibyanTitleState> {
  final FetchLibyanTitles _fetchLibyanTitles;
  LibyanTitleBloc({required FetchLibyanTitles fetchLibyanTitles})
      : _fetchLibyanTitles = fetchLibyanTitles,
        super(LibyanTitleInitial()) {
    on<LibyanTitleFetchEvent>(_onLibyanTitleFetchEvent);
  }

  _onLibyanTitleFetchEvent(LibyanTitleFetchEvent event, emit) async {
    if (event.pageNo == 1) emit(LibyanTitleLoading());
    try {
      List<LibyanTitleModel>? titles;
      if (_hasReachedMax(state) && event.pageNo != 1) {
        return;
      } else if (state is LibyanTitleLoaded) {
        // state is PoemSuccess && state.poemDataModel ?

        titles = _getTitles(state);
        emit(LibyanTitleLoaded(libyans: titles!, loadingMore: true));
      }
      var res = await _fetchLibyanTitles(
        SearchPaginationParams(
            pageNo: event.pageNo, pageSize: event.PageSize, query: ''),
      );

      res.fold(
          (l) => emit(
                LibyanTitleFailure(
                  message: l.message,
                ),
              ), (r) {
        titles != null ? titles!.addAll(r) : titles = r;
        emit(
          LibyanTitleLoaded(
            libyans: titles!,
          ),
        );
      });
    } catch (e) {
      emit(
        LibyanTitleFailure(
          message: "مشكلة ما حاول مجدداً",
        ),
      );
    }
  }

  bool _hasReachedMax(LibyanTitleState state) =>
      state is LibyanTitleLoaded && state.hasReachedMax;

  List<LibyanTitleModel>? _getTitles(LibyanTitleState state) {
    if (state is LibyanTitleLoaded) {
      return state.libyans;
    }
    return null;
  }
}
