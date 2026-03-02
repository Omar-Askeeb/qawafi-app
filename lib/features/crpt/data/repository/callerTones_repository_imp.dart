import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/crpt/data/datasource/callerTonesRemoteDataSource.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTones.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTonesCategory.dart';
import 'package:qawafi_app/features/crpt/domain/repository/callerTones_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/exceptions.dart';

import 'package:qawafi_app/core/error/failures.dart';

class CallerTonesRepositoryImp implements CallerTonesRepository {
  final CallerTonesRemoteDataSource remoteDataSource;

  CallerTonesRepositoryImp({required this.remoteDataSource});


  @override
  Future<Either<Failure, List<CallerTone>>> CallerTonesById(
      {required String Id}) async {
    try {
      var callerTonesResponse = await remoteDataSource.CallerTonesById(
        Id: Id,
      );
      return right(callerTonesResponse);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CallerTonesCategory>>> CellerTonesCategoryByAlpha(
      {required String alphabet, required String gender}) async {
    try {
      final isConnected =
          await ConnectionCheckerImpl(InternetConnection()).isConnected;
      if (!isConnected) {
        // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
        return left(Failure('لا يوجد إتصال بالأنترنت'));
      }
      var callerTonesCategoryResponse =
          await remoteDataSource.CellerTonesCategoryByAlpha(
        alphabet: alphabet,
        gender: gender,
      );
      return right(callerTonesCategoryResponse);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
