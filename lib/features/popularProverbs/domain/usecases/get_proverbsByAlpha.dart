import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/popularProverbs/domain/entites/popularProverbs.dart';
import 'package:qawafi_app/features/popularProverbs/domain/repository/popularProverbs_repository.dart';

class GetProverbsbyalpha implements UseCase<List<PopularProverbs>,ProverbsParam> 
{
  final PopularProverbsRepository popularProverbsRepository;
  
  GetProverbsbyalpha({
    required this.popularProverbsRepository,
  });

  @override
  Future<Either<Failure,List<PopularProverbs>>> call(ProverbsParam params) async {
    return await popularProverbsRepository.popularProverbsByAlpha(alphabet: params.alpha);
  }
}

class ProverbsParam{
  final String alpha;
  ProverbsParam({required this.alpha});

}