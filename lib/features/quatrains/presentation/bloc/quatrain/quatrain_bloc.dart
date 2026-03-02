import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/features/quatrains/data/models/quatrain_model.dart';
import 'package:qawafi_app/features/quatrains/domain/usecases/fetch_quatrain_by_id.dart';
import 'package:qawafi_app/features/quatrains/domain/usecases/fetch_quatrains.dart';

import '../../../domain/usecases/quatrain_id_param.dart';

part 'quatrain_event.dart';
part 'quatrain_state.dart';

class QuatrainBloc extends Bloc<QuatrainEvent, QuatrainState> {
  final FetchQuatrains _fetchQuatrains;
  final FetchQuatrainById _fetchQuatrainById;

  QuatrainBloc(
      {required FetchQuatrains fetchQuatrains,
      required FetchQuatrainById fetchQuatrainById})
      : _fetchQuatrainById = fetchQuatrainById,
        _fetchQuatrains = fetchQuatrains,
        super(QuatrainInitial()) {
    on<QuatrainFetchData>(_onQuatrainFetchData);
    on<QuatrainFetchById>(_onQuatrainFetchById);
  }

  _onQuatrainFetchData(QuatrainFetchData event, emit) async {
    emit(QuatrainLoading());

    var res = await _fetchQuatrains(
      QuatrainParams(
        pageNo: event.pageNo,
        pageSize: event.pageSize,
        query: event.query,
        categoryId: event.categoryId,
      ),
    );

    res.fold(
      (l) => emit(
        QuatrainFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        QuatrainSuccess(
          quatrains: r,
        ),
      ),
    );
  }

  _onQuatrainFetchById(QuatrainFetchById event, emit) async {
    emit(QuatrainLoading());

    var res = await _fetchQuatrainById(
      QuatrianIdParam(
        id: event.id,
      ),
    );

    res.fold(
      (l) => emit(
        QuatrainFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        QuatrainOneSuccess(
          quatrain: r,
        ),
      ),
    );
  }
}
