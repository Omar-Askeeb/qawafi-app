import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poem/data/models/poem_data_model.dart';
import 'package:qawafi_app/features/poem/domain/repository/poem_repository.dart';

class GetPoemByCategoryAndMelody
    implements UseCase<PoemDataModel, GetPoemByCategoryAndMelodyParam> {
  final PoemRepository poemRepository;

  GetPoemByCategoryAndMelody({required this.poemRepository});

  @override
  Future<Either<Failure, PoemDataModel>> call(
      GetPoemByCategoryAndMelodyParam params) async {
    return await poemRepository.getPoemByMelodyOrJustRecite(
        poemCategory: params.poemCategory, melody: params.melody);
  }
}

class GetPoemByCategoryAndMelodyParam {
  final String poemCategory;
  final String? melody;

  GetPoemByCategoryAndMelodyParam({
    required this.poemCategory,
    required this.melody,
  });
}
