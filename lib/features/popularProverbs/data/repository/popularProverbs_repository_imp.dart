import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/popularProverbs/data/datasource/popularProverbs_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/exceptions.dart';

import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/popularProverbs/domain/repository/popularProverbs_repository.dart';
import '../models/popularProverbs.dart';

 
 class PopularProverbsRepositoryImpl implements PopularProverbsRepository {
  final PopularProverbsRemoteDataSource remoteDataSource;

  PopularProverbsRepositoryImpl({
    required this.remoteDataSource
  });

  @override
  Future<Either<Failure, List<PopularProverbsModel>>> popularProverbsByAlpha(
    {required String alphabet}
  ) async {
    
    try {
      final isConnected = await ConnectionCheckerImpl(InternetConnection()).isConnected; 
    if (!isConnected) {
      // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
      return left(Failure('لا يوجد إتصال بالأنترنت'));
    }
      var proverbsResponse = await remoteDataSource.popularProverbsByAlpha(
      alphabet:alphabet,
      );
      return right(proverbsResponse);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

   @override
  Future<Either<Failure,PopularProverbsModel>> popularProverbsByTitel(
    {required String titel}
  ) async {
    
    try {
      var proverbsResponse = await remoteDataSource.popularProverbsByTitel(
      titel: titel,
      );
      return right(proverbsResponse);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }





}
