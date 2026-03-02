import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/reel_model.dart';

abstract class ReelsRepository {
  Future<Either<Failure, List<ReelModel>>> getReels();
}
