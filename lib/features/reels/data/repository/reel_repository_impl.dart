import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repository/reel_repository.dart';
import '../datasources/reel_remote_datasource.dart';
import '../models/reel_model.dart';

class ReelsRepositoryImpl implements ReelsRepository {
  final ReelsRemoteDataSource remoteDataSource;

  ReelsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ReelModel>>> getReels() async {
    try {
      return Right(await remoteDataSource.fetchReels());
    } catch (e) {
      return Left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
