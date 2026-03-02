import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/melody/domain/usecases/get_melodies.dart';

import '../../domain/entities/melody.dart';

part 'melody_event.dart';
part 'melody_state.dart';

class MelodyBloc extends Bloc<MelodyEvent, MelodyState> {
  final GetMelodies _getMelodies;
  MelodyBloc({required GetMelodies getMelodies})
      : _getMelodies = getMelodies,
        super(MelodyInitial()) {
    on<MelodyGetAll>(_getMelodiesE);
  }

  _getMelodiesE(event, emit) async {
    emit(MelodyLoading());

    final res = await _getMelodies(NoParams());

    res.fold(
      (l) => emit(
        MelodyFailuer(
          l.message,
        ),
      ),
      (r) => emit(
        MelodySuccess(
          melodies: r,
        ),
      ),
    );
  }
}
