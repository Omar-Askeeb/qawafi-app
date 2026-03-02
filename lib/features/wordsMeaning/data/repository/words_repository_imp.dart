import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/wordsMeaning/data/datasource/word_remote_data_source.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/entities/paginatedWords.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/repository/word_repository.dart';

class WordsRepositoryImpl implements WordsRepository {
  final WordRemoteDataSource remoteDataSource;

  WordsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedWords>> fetchWords(int pageNumber, int pageSize,String query) async {
    try {
        final isConnected = await ConnectionCheckerImpl(InternetConnection()).isConnected; 
    if (!isConnected) {
      // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
      return left(Failure('لا يوجد إتصال بالأنترنت'));
    }
      final paginatedWordsModel = await remoteDataSource.fetchWords(pageNumber, pageSize,query);
      return Right(paginatedWordsModel);
    } catch (exception) {
      return Left(Failure( exception.toString()));
    }
  }
}
