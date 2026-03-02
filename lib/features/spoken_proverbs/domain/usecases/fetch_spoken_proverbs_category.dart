import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/repository/spoken_proverbs_repository.dart';

import '../../data/models/spoken_proverb_category_model.dart';

class FetchSpokenProverbCategories
    implements UseCase<List<SpokenProverbCategoryModel>, NoParams> {
  final SpokenProverbRepository repository;

  FetchSpokenProverbCategories({required this.repository});
  @override
  Future<Either<Failure, List<SpokenProverbCategoryModel>>> call(
      NoParams params) async {
    return await repository.fetchCategories();
  }
}
