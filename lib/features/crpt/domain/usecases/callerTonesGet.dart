import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/crpt/domain/entites/callerTones.dart';
import 'package:qawafi_app/features/crpt/domain/repository/callerTones_repository.dart';

class CallerTonesGet implements UseCase<List<CallerTone>,CallerTonesParams> 
{
  final CallerTonesRepository callerTonesRepository;
  
  CallerTonesGet({
    required this.callerTonesRepository,
  });

  @override
  Future<Either<Failure,List<CallerTone>>> call(CallerTonesParams params) async {
    return await callerTonesRepository.CallerTonesById(Id: params.Id);
  }
}

class CallerTonesParams{
  final String Id;
  CallerTonesParams({required this.Id});

}