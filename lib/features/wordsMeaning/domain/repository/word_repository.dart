
import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/entities/paginatedWords.dart';

abstract class WordsRepository {
  Future<Either<Failure, PaginatedWords>> fetchWords(int pageNumber, int pageSize,String query);
}
