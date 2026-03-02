import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../poem/data/models/poem_model.dart';
import '../../../quatrains/data/models/quatrain_model.dart';
import '../../../storyProverb/data/models/proverbStoryModel.dart';

abstract interface class FavoriteRepository {
  Future<Either<Failure, List<PoemModel>>> fetchMyPoemFav({
    required String userId,
  });
  // Future<List<PoemModel>> fetchMyFav({
  //   required String userId,
  // });

  Future<Either<Failure, List<QuatrainModel>>> fetchMyQuatrainFav({
    required String userId,
  });

  Future<Either<Failure, List<ProverbStoryModel>>> fetchMyProverbStoryFav({
    required String userId,
  });
}
