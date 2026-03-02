
import 'package:qawafi_app/features/crpt/domain/entites/callerTones.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTonesCategory.dart';
import 'package:qawafi_app/features/crpt/domain/usecases/callerTonesGet.dart';

import '/../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CallerTonesRepository {
  Future<Either<Failure, List<CallerTonesCategory>>> CellerTonesCategoryByAlpha( {
    required String alphabet,
    required String gender
  });

  Future<Either<Failure,List<CallerTone>>> CallerTonesById({
    required String Id
  });
}
