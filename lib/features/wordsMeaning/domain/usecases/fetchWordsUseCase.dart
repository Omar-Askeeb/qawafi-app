import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/entities/paginatedWords.dart';
import 'package:qawafi_app/features/wordsMeaning/domain/repository/word_repository.dart';

class FetchWordsUseCase {
  final WordsRepository repository;

  FetchWordsUseCase(this.repository);

  Future<Either<Failure, PaginatedWords>> call(int pageNumber, int pageSize,String query) async {
    return await repository.fetchWords(pageNumber, pageSize,query);
  }
}
