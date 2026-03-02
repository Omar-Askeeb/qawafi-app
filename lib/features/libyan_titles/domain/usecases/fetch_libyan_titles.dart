import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/search_pagination_params.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';
import 'package:qawafi_app/features/libyan_titles/domain/repository/libyan_title_repository.dart';

class FetchLibyanTitles
    implements UseCase<List<LibyanTitleModel>, SearchPaginationParams> {
  final LibyanTitleRepository repository;

  FetchLibyanTitles({required this.repository});
  @override
  Future<Either<Failure, List<LibyanTitleModel>>> call(
      SearchPaginationParams params) async {
    return await repository.fetchLibyanTitles(
      pageNo: params.pageNo,
      pageSize: params.pageSize,
    );
  }
}
