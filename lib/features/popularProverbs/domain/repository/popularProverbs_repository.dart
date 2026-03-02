import '../entites/popularProverbs.dart';
import '/../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PopularProverbsRepository {
  Future<Either<Failure, List<PopularProverbs>>> popularProverbsByAlpha({
    required String alphabet
  });

  Future<Either<Failure,PopularProverbs>> popularProverbsByTitel({
    required String titel
  });
}
