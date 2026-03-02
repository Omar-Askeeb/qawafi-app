import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTonesCategory.dart';
import 'package:qawafi_app/features/crpt/domain/usecases/callerTonesCategory.dart';
part 'CallerTonesCategory_state.dart';
part 'CallerTonesCategory_Event.dart';

class CallerTonesCategoryBloc
    extends Bloc<CallerTonesCategoryEvent, CallerTonesCategoryState> {
  final CallerTonesCategoryGet _getCallerTonesCategorybyalphaa;
  CallerTonesCategoryBloc(
      {required CallerTonesCategoryGet getCallerTonesCategory})
      : _getCallerTonesCategorybyalphaa = getCallerTonesCategory,
        super(CallerTonesCategoryInitial()) {
    on<CallerTonesCategoryByAlpha>(_getCallerTonesCategorybyalpha);
  }
  _getCallerTonesCategorybyalpha(CallerTonesCategoryByAlpha event, emit) async {
    emit(CallerTonesCategoryLoading());
    try {
      final res = await _getCallerTonesCategorybyalphaa.call(
        CallerTonesCategoryParams(
          alphabet: event.alpha, gender: event.gender
            ),
      );
      res.fold(
      (l) => emit(CallerTonesCategoryFailure(message: l.message)),
      (r) => emit(CallerTonesCategoryLoaded(callerTonesCategory: r)),
      );
      
    } catch (e) {
      emit(
        CallerTonesCategoryFailure(message: "مشكلة ما الرجاء إعادة المحاولة"),
      );
    }
  }
}
