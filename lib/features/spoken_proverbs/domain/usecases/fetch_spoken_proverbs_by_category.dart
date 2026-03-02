import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/string_param.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/spoken_proverbs/domain/repository/spoken_proverbs_repository.dart';

import '../../data/models/spoken_proverb_model.dart';

class FetchSpokenProverbByCategory
    implements UseCase<List<SpokenProverbModel>, StringParam> {
  final SpokenProverbRepository repository;

  FetchSpokenProverbByCategory({required this.repository});
  @override
  Future<Either<Failure, List<SpokenProverbModel>>> call(
      StringParam params) async {
    return await repository.fetchSpokenProverbByCategory(
      categoryId: params.string,
    );
  }
}
