import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/usecases/get_most_streamed.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';
import 'package:qawafi_app/features/poet/domain/usecases/fetch_poets.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMostStreamed _getMostStreamed;
  final FetchPoets _fetchPoets;
  HomeBloc({
    required GetMostStreamed getMostStreamed,
    required FetchPoets fetchPoets,
  })  : _getMostStreamed = getMostStreamed,
        _fetchPoets = fetchPoets,
        super(HomeInitial()) {
    on<HomeFetchDataEvent>(_onHomeFetchDataEvent);
  }

  _onHomeFetchDataEvent(
      HomeFetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final poetsResult =
        await _fetchPoets(FetchPoetsParams(query: "", pageNo: 1, pageSize: 20));
    final poemsResult = await _getMostStreamed(NoParams());

    poetsResult.fold(
      (failure) => emit(HomeFailure(message: failure.message)),
      (poets) {
        poemsResult.fold(
          (failure) => emit(HomeFailure(message: failure.message)),
          (poems) => emit(HomeLoaded(poets: poets, poems: poems)),
        );
      },
    );
  }
}
