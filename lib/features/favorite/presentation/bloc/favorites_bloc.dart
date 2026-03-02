import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/features/favorite/domain/usecases/fetch_fav_poems.dart';
import 'package:qawafi_app/features/favorite/domain/usecases/fetch_fav_proverbs.dart';
import 'package:qawafi_app/features/favorite/domain/usecases/fetch_fav_quatrians.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import 'package:qawafi_app/features/storyProverb/data/models/proverbStoryModel.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FetchFavPoems _fetchFavPoems;
  final FetchFavProverbs _fetchFavProverbs;
  final FetchFavQuatrains _fetchFavQuatrains;
  final AppUserCubit _appUserCubit;
  FavoritesBloc(
      {required FetchFavPoems fetchFavPoems,
      required FetchFavProverbs fetchFavProverbs,
      required FetchFavQuatrains fetchFavQuatrains,
      required AppUserCubit appUserCubit})
      : _fetchFavPoems = fetchFavPoems,
        _fetchFavProverbs = fetchFavProverbs,
        _fetchFavQuatrains = fetchFavQuatrains,
        _appUserCubit = appUserCubit,
        super(FavoritesInitial()) {
    on<FavoriteFetchEvent>(_onFavoriteFetchEvent);
  }

  _onFavoriteFetchEvent(FavoriteFetchEvent event, emit) async {
    emit(FavoritesLoading());

    if (_appUserCubit.state is! AppUserLoggedIn) {
      emit(FavoritesFailure(message: "لابد من التسجيل لعرض محتويات المفضلة"));
      return;
    }

    final userId = (_appUserCubit.state as AppUserLoggedIn).user.id;

    try {
      final poemsResult = await _fetchFavPoems(StringParam(string: userId));
      final quatrainsResult =
          await _fetchFavQuatrains(StringParam(string: userId));
      final proverbsResult =
          await _fetchFavProverbs(StringParam(string: userId));

      if (poemsResult.isLeft() ||
          quatrainsResult.isLeft() ||
          proverbsResult.isLeft()) {
        emit(FavoritesFailure(message: "فشل في تحميل المحتويات المفضلة"));
        return;
      }

      // Extract data from results
      final List<PoemModel> poems =
          poemsResult.fold((failure) => [], (poems) => poems);
      final List<QuatrainModel> quatrains =
          quatrainsResult.fold((failure) => [], (quatrains) => quatrains);
      final List<ProverbStoryModel> proverbs =
          proverbsResult.fold((failure) => [], (proverbs) => proverbs);

      emit(FavoritesSuccess(
        poems: poems,
        quatrains: quatrains,
        proverbs: proverbs,
      ));
    } catch (e) {
      log(e.toString());
      emit(FavoritesFailure(message: "حدث خطأ أثناء تحميل المحتويات المفضلة"));
    }
  }
}
