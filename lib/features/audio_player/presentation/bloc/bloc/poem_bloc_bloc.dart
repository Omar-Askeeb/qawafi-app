import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/features/poem/data/models/poem_model.dart';
import 'package:qawafi_app/features/poem/domain/usecases/get_poem_by_id.dart';

part 'poem_bloc_event.dart';
part 'poem_bloc_state.dart';

class PoemBlocBloc extends Bloc<PoemBlocEvent, PoemBlocState> {
  final GetPoemById _getPoemById;
  PoemBlocBloc({
    required GetPoemById getPoemById,
  })  : _getPoemById = getPoemById,
        super(PoemBlocInitial()) {
    on<PoemBlocFetchEvent>(_onPoemBlocFetchEvent);
  }

  _onPoemBlocFetchEvent(PoemBlocFetchEvent event, emit) async {
    emit(PoemBlocLoading());

    var res = await _getPoemById(StringParam(string: event.poemId));

    res.fold(
      (l) => emit(
        PoemBlocFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        PoemBlocLoaded(
          poem: r,
        ),
      ),
    );
  }
}
