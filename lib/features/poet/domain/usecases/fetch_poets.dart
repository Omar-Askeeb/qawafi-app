import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/poet/data/models/poet.dart';
import 'package:qawafi_app/features/poet/domain/repository/poet_repository.dart';

class FetchPoets implements UseCase<List<PoetModel>, FetchPoetsParams> {
  final PoetRepositroy poetRepositroy;

  FetchPoets({required this.poetRepositroy});

  @override
  Future<Either<Failure, List<PoetModel>>> call(FetchPoetsParams params) async {
    return await poetRepositroy.getPoets(
      pageNo: params.pageNo,
      pageSize: params.pageSize,
      query: params.query,
    );
  }
}

class FetchPoetsParams {
  final String? query;
  final int pageNo;
  final int pageSize;

  FetchPoetsParams(
      {required this.query, required this.pageNo, required this.pageSize});
}
