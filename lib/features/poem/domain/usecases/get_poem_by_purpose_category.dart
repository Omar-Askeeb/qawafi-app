import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/repository/poem_repository.dart';

class GetPoemByPurposeAndCategory
    implements UseCase<PoemDataModel, GetPoemByPurposeAndCategoryParam> {
  final PoemRepository poemRepository;

  GetPoemByPurposeAndCategory({required this.poemRepository});

  @override
  Future<Either<Failure, PoemDataModel>> call(
      GetPoemByPurposeAndCategoryParam params) async {
    return await poemRepository.getPoemByPurposeAndCategory(
      purpose: params.purpose,
      poemCategory: params.poemCategory,
      pageNo: params.pageNo,
      pageSize: params.pageSize,
    );
  }
}

class GetPoemByPurposeAndCategoryParam {
  final String purpose;
  final String poemCategory;
  final int pageNo;
  final pageSize;

  GetPoemByPurposeAndCategoryParam({
    required this.purpose,
    required this.poemCategory,
    required this.pageNo,
    required this.pageSize,
  });
}
