import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/enums/search_keys.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/repository/poem_repository.dart';

class SearchPoems implements UseCase<PoemDataModel, SearchPoemsParams> {
  final PoemRepository poemRepository;

  SearchPoems({required this.poemRepository});
  @override
  Future<Either<Failure, PoemDataModel>> call(SearchPoemsParams params) async {
    return await poemRepository.searchPoems(
      searchKey: params.searchKeys,
      searchValue: params.searchValue,
      pageNo: params.pageNo,
      pageSize: params.pageSize,
    );
  }
}

class SearchPoemsParams {
  final SearchKeys searchKeys;
  final String searchValue;
  final int pageNo;
  final int pageSize;

  SearchPoemsParams({
    required this.searchKeys,
    required this.searchValue,
    required this.pageNo,
    required this.pageSize,
  });
}
