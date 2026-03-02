import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/usecases/get_poem_by_poet.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';
import 'package:qawafi_app/features/poet/domain/usecases/fetch_poet.dart';
import 'package:qawafi_app/features/poet/domain/usecases/fetch_poets.dart';
import 'package:qawafi_app/features/poet/domain/usecases/follow_poet.dart';

import '../../../../../core/usecase/poem_id_param.dart';
import '../../../domain/usecases/unfollow_poet.dart';

part 'poet_event.dart';
part 'poet_state.dart';

class PoetBloc extends Bloc<PoetEvent, PoetState> {
  final FetchPoets _fetchPoets;
  final FetchPoet _fetchPoet;
  final FollowPoet _followPoet;
  final UnFollowPoet _unFollowPoet;
  final GetPoemByPoetId _getPoemByPoetId;
  PoetSuccess? _poetSuccess;

  PoetBloc({
    required FetchPoets fetchPoets,
    required FetchPoet fetchPoet,
    required FollowPoet followPoet,
    required UnFollowPoet unFollowPoet,
    required GetPoemByPoetId getPoemByPoetId,
  })  : _fetchPoets = fetchPoets,
        _fetchPoet = fetchPoet,
        _getPoemByPoetId = getPoemByPoetId,
        _followPoet = followPoet,
        _unFollowPoet = unFollowPoet,
        super(PoetInitial()) {
    on<PoetGetPoets>(_getPoets);
    on<PoetGoToDetails>(_goToDetails);
    on<PoetNavigateBack>(_onPoetNavigateBack);
    on<PoetFollow>(_onPoetFollow);
    on<PoetUnFollow>(_onPoetUnFollow);
  }

  _getPoets(PoetGetPoets event, emit) async {
    if (event.pageNo == 1) emit(PoetLoading());
    try {
      List<PoetModel>? poets;
      if (state is PoetSuccess) {
        poets = _getOldPoets(state);
        emit(PoetSuccess(poets: poets!, loadingMore: true));
      }
      var res = await _fetchPoets(FetchPoetsParams(
        pageNo: event.pageNo,
        pageSize: event.PageSize,
        query: event.query,
      ));

      res.fold(
          (l) => emit(
                PoetFailuer(
                  message: l.message,
                ),
              ), (r) {
        poets != null ? poets!.addAll(r) : poets = r;
        _poetSuccess = PoetSuccess(poets: poets!);
        emit(
          _poetSuccess,
        );
      });
    } catch (e) {
      emit(
        PoetFailuer(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }

  _goToDetails(PoetGoToDetails event, emit) async {
    emit(PoetLoading());
    try {
      var res = await _fetchPoet(FetchPoetParams(poetId: event.poetId));
      var res2 =
          await _getPoemByPoetId(GetPoemByPoetIdParams(poetId: event.poetId));
      PoetModel? poet;
      PoemDataModel? poemData;
      res.fold(
        (l) => emit(
          PoetFailuer(
            message: l.toString(),
          ),
        ),
        (r) => poet = r,
      );

      res2.fold(
          (l) => emit(
                PoetFailuer(
                  message: l.toString(),
                ),
              ),
          (r) => poemData = r);
      if (poemData != null && poet != null) {
        emit(PoetProfile(poet: poet!, poems: poemData!));
      }
    } catch (e) {
      emit(
        PoetFailuer(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }

  _onPoetNavigateBack(event, emit) {
    if (_poetSuccess != null) {
      emit(_poetSuccess!);
    }
    // else {
    //   _getPoets(PoetGetPoets(event), emit);
    // }
  }

  _onPoetFollow(PoetFollow event, emit) async {
    PoemDataModel? poems =
        state is PoetProfile ? (state as PoetProfile).poems : null;
    emit(PoetLoading());
    try {
      var res = await _followPoet(PoemIdParam(poetId: event.poetId));

      res.fold(
        (l) => emit(
          PoetFailuer(
            message: l.toString(),
          ),
        ),
        (r) => emit(PoetProfile(
            poet: r,
            poems: poems ??
                PoemDataModel(
                    pageNumber: 1,
                    poems: [],
                    pageSize: 30,
                    totalAvailable: 0))),
      );
    } catch (e) {
      emit(
        PoetFailuer(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }

  _onPoetUnFollow(PoetUnFollow event, emit) async {
    PoemDataModel? poems =
        state is PoetProfile ? (state as PoetProfile).poems : null;
    emit(PoetLoading());
    try {
      var res = await _unFollowPoet(PoemIdParam(poetId: event.poetId));

      res.fold(
        (l) => emit(
          PoetFailuer(
            message: l.toString(),
          ),
        ),
        (r) => emit(PoetProfile(
            poet: r,
            poems: poems ??
                PoemDataModel(
                    pageNumber: 1,
                    poems: [],
                    pageSize: 30,
                    totalAvailable: 0))),
      );
    } catch (e) {
      emit(
        PoetFailuer(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }

  List<PoetModel>? _getOldPoets(PoetState state) {
    if (state is PoetSuccess) {
      return state.poets;
    }
    return null;
  }
}
