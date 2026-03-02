import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/purpose/data/datasources/purpose_remote_data_source.dart';
import 'package:qawafi_app/features/purpose/data/models/purpose_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/purpose_repository.dart';

class PurposeRepositoryImpl implements PurposeRepository {
  final PurposeRemoteDatasource remoteDatasource;

  PurposeRepositoryImpl({required this.remoteDatasource});
  @override
  Future<Either<Failure, List<PurposeModel>>> fetchPurposeAll() async {
    try {
      return right(
        await remoteDatasource.fetchPurposeAll(),
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
