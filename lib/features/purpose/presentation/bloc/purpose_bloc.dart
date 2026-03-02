import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/purpose/domain/usecases/fetch_purpose_all.dart';

import '../../domain/entites/purpose.dart';

part 'purpose_event.dart';
part 'purpose_state.dart';

class PurposeBloc extends Bloc<PurposeEvent, PurposeState> {
  final FetchPurposeAll _fetchPurposeAll;
  PurposeBloc({required FetchPurposeAll fetchPurposeAll})
      : _fetchPurposeAll = fetchPurposeAll,
        super(PurposeInitial()) {
    on<PurposeFetchAll>(_purposeFetchAll);
  }

  _purposeFetchAll(event, emit) async {
    // TODO: implement event handler

    emit(PurposeLoading());
    final res = await _fetchPurposeAll(null);

    res.fold(
      (l) => emit(
        PurposeFailure(message: l.message),
      ),
      (r) => emit(
        PurposeSuccess(purposes: r),
      ),
    );
  }
}
