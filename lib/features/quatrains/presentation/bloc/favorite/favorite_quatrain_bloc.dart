import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import 'package:qawafi_app/features/quatrains/domain/usecases/quatrain_add_to_favorite.dart';
import 'package:qawafi_app/features/quatrains/domain/usecases/quatrain_remove_from_favorite.dart';

import '../../../domain/usecases/quatrain_id_param.dart';

part 'favorite_quatrain_event.dart';
part 'favorite_quatrain_state.dart';

class FavoriteQuatrainBloc
    extends Bloc<FavoriteQuatrainEvent, FavoriteQuatrainState> {
  final QuatrainAdd2Favorite _quatrainAdd2Favorite;
  final QuatrainRemoveFromFavorite _quatrainRemoveFromFavorite;
  FavoriteQuatrainBloc({
    required QuatrainAdd2Favorite quatrainAdd2Favorite,
    required QuatrainRemoveFromFavorite quatrainRemoveFromFavorite,
  })  : _quatrainAdd2Favorite = quatrainAdd2Favorite,
        _quatrainRemoveFromFavorite = quatrainRemoveFromFavorite,
        super(FavoriteQuatrainInitial()) {
    on<FavoriteQuatrainInit>(_onFavoriteQuatrainInit);
    on<FavoriteQuatrainAdd>(_onFavoriteAdd);
    on<FavoriteQuatrainRemove>(_onFavoriteRemove);
  }

  _onFavoriteQuatrainInit(FavoriteQuatrainInit event, emit) {
    emit(
      FavoriteQuatrainSuccess(quatrain: event.quatrain),
    );
  }

  _onFavoriteAdd(FavoriteQuatrainAdd event, emit) async {
    emit(FavoriteQuatrainLoading());

    var res = await _quatrainAdd2Favorite(
      QuatrianIdParam(id: event.id),
    );

    res.fold(
      (l) => emit(
        FavoriteQuatrainFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        FavoriteQuatrainSuccess(
          quatrain: r,
        ),
      ),
    );
  }

  _onFavoriteRemove(FavoriteQuatrainRemove event, emit) async {
    emit(FavoriteQuatrainLoading());

    var res = await _quatrainRemoveFromFavorite(
      QuatrianIdParam(id: event.id),
    );

    res.fold(
      (l) => emit(
        FavoriteQuatrainFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        FavoriteQuatrainSuccess(
          quatrain: r,
        ),
      ),
    );
  }
}
