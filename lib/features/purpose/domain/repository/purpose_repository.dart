import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/purpose/domain/entites/purpose.dart';

abstract interface class PurposeRepository {
  Future<Either<Failure, List<Purpose>>> fetchPurposeAll();
}
