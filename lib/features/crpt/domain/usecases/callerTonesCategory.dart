import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/crpt/data/models/callerTonesModel.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTonesCategory.dart';
import 'package:qawafi_app/features/crpt/domain/repository/callerTones_repository.dart';

class CallerTonesCategoryGet implements UseCase<List<CallerTonesCategory>,CallerTonesCategoryParams> 
{
  final CallerTonesRepository callerTonesRepository;
  
  CallerTonesCategoryGet({
    required this.callerTonesRepository,
  });

  @override
  Future<Either<Failure,List<CallerTonesCategory>>> call(CallerTonesCategoryParams params) async {
    return await callerTonesRepository.CellerTonesCategoryByAlpha(alphabet: params.alphabet,gender: params.gender);
  }
}

class CallerTonesCategoryParams{
  final String alphabet;
  final String gender;
  CallerTonesCategoryParams({required this.alphabet,required this.gender});

}