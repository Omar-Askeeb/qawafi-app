import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/poem_id_param.dart';
import 'package:qawafi_app/features/poem/domain/entites/poem.dart';
import 'package:qawafi_app/features/poem/domain/usecases/add_to_favorite.dart';
import 'package:qawafi_app/features/poem/domain/usecases/remove_to_favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Add2Favorite _add2favorite;
  final Remove2Favorite _remove2favorite;
  FavoriteBloc({
    required Add2Favorite add2favorite,
    required Remove2Favorite remove2favorite,
  })  : _add2favorite = add2favorite,
        _remove2favorite = remove2favorite,
        super(FavoriteInitial()) {
    on<FavoriteInit>(_onFavoriteInit);
    on<FavoriteAdd>(_onFavoriteAdd);
    on<FavoriteRemove>(_onFavoriteRemove);
  }

  _onFavoriteInit(FavoriteInit event, emit) {
    emit(
      FavoriteSuccess(poem: event.poem),
    );
  }

  _onFavoriteAdd(FavoriteAdd event, emit) async {
    emit(FavoriteLoading());

    var res = await _add2favorite(
      PoemIdParam(
        poetId: event.poemId,
      ),
    );

    res.fold(
      (l) => emit(
        FavoriteFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        FavoriteSuccess(
          poem: r,
        ),
      ),
    );
  }

  _onFavoriteRemove(FavoriteRemove event, emit) async {
    emit(FavoriteLoading());

    var res = await _remove2favorite(
      PoemIdParam(
        poetId: event.poemId,
      ),
    );

    res.fold(
      (l) => emit(
        FavoriteFailure(message: l.message),
      ),
      (r) => emit(
        FavoriteSuccess(
          poem: r,
        ),
      ),
    );
  }
}
