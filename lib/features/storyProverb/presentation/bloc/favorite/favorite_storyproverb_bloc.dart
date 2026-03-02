import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';
import 'package:qawafi_app/features/storyProverb/domain/entities/proverbStory.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/storyProverb_add_to_favorite.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/storyProverb_remove_from_favorite.dart';
import 'package:qawafi_app/features/storyProverb/domain/usecases/storyProverpParm.dart';

part 'favorite_storyproverb_event.dart';
part 'favorite_storyproverb_state.dart';

class FavoriteStoryProverbBloc
    extends Bloc<FavoriteStoryProverbEvent, FavoriteStoryProverbState> {
  final StoryProverbAdd2Favorite _storyProverbAdd2Favorite;
  final StoryProverbRemoveFromFavorite _storyProverbRemoveFromFavorite;
  FavoriteStoryProverbBloc({
    required StoryProverbAdd2Favorite storyProverbAdd2Favorite,
    required StoryProverbRemoveFromFavorite storyProverbRemoveFromFavorite,
  })  : _storyProverbAdd2Favorite = storyProverbAdd2Favorite,
        _storyProverbRemoveFromFavorite = storyProverbRemoveFromFavorite,
        super(FavoriteStoryProverbInitial()) {
    on<FavoriteStoryProverbInit>(_onFavoriteStoryProverbInit);
    on<FavoriteStoryProverbAdd>(_onFavoriteAdd);
    on<FavoriteStoryProverbRemove>(_onFavoriteRemove);
  }

  _onFavoriteStoryProverbInit(FavoriteStoryProverbInit event, emit) {
    emit(
      FavoriteStoryProverbSuccess(proverbStory: event.proverbStory),
    );
  }

  _onFavoriteAdd(FavoriteStoryProverbAdd event, emit) async {
    emit(FavoriteStoryProverbLoading());

    var res = await _storyProverbAdd2Favorite(
      StoryProverbIdParam(id: event.id),
    );

    res.fold(
      (l) => emit(
        FavoriteStoryProverbFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        FavoriteStoryProverbSuccess(
          proverbStory: r,
        ),
      ),
    );
  }

  _onFavoriteRemove(FavoriteStoryProverbRemove event, emit) async {
    emit(FavoriteStoryProverbLoading());

    var res = await _storyProverbRemoveFromFavorite(
      StoryProverbIdParam(id: event.id),
    );

    res.fold(
      (l) => emit(
        FavoriteStoryProverbFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        FavoriteStoryProverbSuccess(
          proverbStory: r,
        ),
      ),
    );
  }
}
