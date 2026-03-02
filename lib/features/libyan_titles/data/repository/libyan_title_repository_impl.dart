import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/libyan_titles/data/datasources/libyan_title_remote_datasource.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';
import 'package:qawafi_app/features/libyan_titles/domain/repository/libyan_title_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/connection_checker.dart';

class LibyanTitleRepositoryImpl implements LibyanTitleRepository {
  final LibyanTitleRemoteDatasource libyanTitleRemoteDatasource;
  final ConnectionChecker connectionChecker;

  LibyanTitleRepositoryImpl(
      {required this.libyanTitleRemoteDatasource,
      required this.connectionChecker});
  @override
  Future<Either<Failure, List<LibyanTitleModel>>> fetchLibyanTitles(
      {required int pageNo, required int pageSize}) async {
    try {
      if (await (connectionChecker.isConnected)) {
        var res = await libyanTitleRemoteDatasource.fetchLibyanTitles(
          pageNo: pageNo,
          pageSize: pageSize,
        );
        return right(res);
      }
      throw NoInternetConnectionException();
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, LibyanTitleModel>> getTitleById(
      {required String id}) async {
    try {
      if (await (connectionChecker.isConnected)) {
        var res = await libyanTitleRemoteDatasource.getTitleById(
          id: id,
        );
        return right(res);
      }
      throw NoInternetConnectionException();
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
