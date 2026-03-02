import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/spoken_proverbs/data/models/spoken_proverb_category_model.dart';

import '../../data/models/spoken_proverb_model.dart';

abstract interface class SpokenProverbRepository {
  Future<Either<Failure, List<SpokenProverbCategoryModel>>> fetchCategories();
  Future<Either<Failure, List<SpokenProverbModel>>>
      fetchSpokenProverbByCategory({required String categoryId});
}
