import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/melody/domain/repository/melody_repository.dart';

import '../entities/melody.dart';

class GetMelodies implements UseCase<List<Melody>, NoParams> {
  final MelodyRepository melodyRepository;

  GetMelodies({required this.melodyRepository});

  @override
  Future<Either<Failure, List<Melody>>> call(NoParams params) {
    return melodyRepository.getMelodies();
  }
}
