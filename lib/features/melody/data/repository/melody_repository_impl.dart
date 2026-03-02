import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/exceptions.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/melody/data/datasources/melody_remote_data_source.dart';
import 'package:qawafi_app/features/melody/domain/entities/melody.dart';
import 'package:qawafi_app/features/melody/domain/repository/melody_repository.dart';

class MelodyRepositoryImpl implements MelodyRepository {
  final MelodyRmoteDatasource melodyRmoteDatasource;
  final ConnectionChecker connectionChecker;

  MelodyRepositoryImpl({
    required this.melodyRmoteDatasource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Melody>>> getMelodies() async {
    try {
      if (await (connectionChecker.isConnected)) {
        var res = await melodyRmoteDatasource.getMelodies();
        return right(res);
      }
      throw NoInternetConnectionException();
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
