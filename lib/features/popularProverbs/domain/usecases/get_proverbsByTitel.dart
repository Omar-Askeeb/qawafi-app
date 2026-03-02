import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/popularProverbs/domain/entites/popularProverbs.dart';
import 'package:qawafi_app/features/popularProverbs/domain/repository/popularProverbs_repository.dart';

class GetProverbsbytitel implements UseCase<PopularProverbs,ProverbsParam>
{
  final PopularProverbsRepository popularProverbsRepository;

  GetProverbsbytitel({
    required this.popularProverbsRepository
  });

  @override
  Future<Either<Failure,PopularProverbs>> call(ProverbsParam params) async {
    return await popularProverbsRepository.popularProverbsByTitel(titel: params.titel);
  }

}
class ProverbsParam{
  final String titel;
  ProverbsParam({required this.titel});
}

