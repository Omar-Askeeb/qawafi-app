import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';

import '../entities/melody.dart';

abstract interface class MelodyRepository {
  Future<Either<Failure, List<Melody>>> getMelodies();
}
