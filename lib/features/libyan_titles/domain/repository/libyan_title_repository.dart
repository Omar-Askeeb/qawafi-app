import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/libyan_titles/data/models/libyan_title_model.dart';

abstract interface class LibyanTitleRepository {
  Future<Either<Failure, List<LibyanTitleModel>>> fetchLibyanTitles(
      {required int pageNo, required int pageSize});

  Future<Either<Failure, LibyanTitleModel>> getTitleById({required String id});
}
