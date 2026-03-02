import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/reel_model.dart';
import '../repository/reel_repository.dart';

class FetchReels implements UseCase<List<ReelModel>, NoParams> {
  final ReelsRepository repository;

  FetchReels({required this.repository});

  Future<Either<Failure, List<ReelModel>>> call(NoParams params) async {
    return await repository.getReels();
  }
}
