import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qawafi_app/core/usecase/search_pagination_params.dart';
import 'package:qawafi_app/features/quatrains_category/data/models/quatrains_category_model.dart';

import '../../domain/usecases/fetch_quatrains_category.dart';

part 'quatrains_category_event.dart';
part 'quatrains_category_state.dart';

class QuatrainsCategoryBloc
    extends Bloc<QuatrainsCategoryEvent, QuatrainsCategoryState> {
  final FetchQuatrainsCategory _fetchQuatrainsCategory;
  QuatrainsCategoryBloc(
      {required FetchQuatrainsCategory fetchQuatrainsCategory})
      : _fetchQuatrainsCategory = fetchQuatrainsCategory,
        super(QuatrainsCategoryInitial()) {
    on<QuatrainsCategoryFetch>(_onQuatrainsCategoryFetch);
  }

  _onQuatrainsCategoryFetch(QuatrainsCategoryFetch event, emit) async {
    emit(QuatrainsCategoryLoading());

    var res = await _fetchQuatrainsCategory(
      SearchPaginationParams(
        pageNo: event.pageNo,
        pageSize: event.pageSize,
        query: event.query,
      ),
    );

    res.fold(
      (l) => emit(
        QuatrainsCategoryFailure(
          message: l.message,
        ),
      ),
      (r) => emit(
        QuatrainsCategorySuccess(
          list: r,
        ),
      ),
    );
  }
}
