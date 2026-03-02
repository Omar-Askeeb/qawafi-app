import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:qawafi_app/features/crpt/domain/usecases/callerTonesGet.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTones.dart';
part 'CallerTones_state.dart';
part 'CallerTones_Event.dart';

class CallerTonesBloc extends Bloc<CallerTonesEvent, CallerTonesState> {
  final CallerTonesGet _getCallerTonesbyID;
  CallerTonesBloc({required CallerTonesGet getCallerTones})
      : _getCallerTonesbyID = getCallerTones,
        super(CallerTonesInitial()) {
    on<CallerTonesByID>(_getCallerTonesbyId);
  }
  _getCallerTonesbyId(CallerTonesByID event, emit) async {
    emit(CallerTonesLoading());
    try {
      final res = await _getCallerTonesbyID.call(
        CallerTonesParams(
          Id: event.Id,
        ),
      );
      res.fold(
        (l) => emit(CallerTonesFailure(message: l.message)),
        (r) {
          if (r.isEmpty) {
            emit(CallerTonesFailure(message: "لا توجد رنات لإسمك سنوفرها قريباُ"));
            return;
          }
          emit(CallerTonesLoaded(callerTones: r));
        },
      );
    } catch (e) {
      emit(
        CallerTonesFailure(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }
}
