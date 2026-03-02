import 'package:fpdart/src/either.dart';

import 'package:qawafi_app/core/error/failures.dart';

import 'package:qawafi_app/features/ads/data/models/advertisement_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/advertisement_repository.dart';
import '../datasource/ads_remote_datasource.dart';

class AdvertisementRepositoryImpl implements AdvertisementRepository {
  final AdvertisementRemoteDatasource adversimentRemoteDatasource;

  AdvertisementRepositoryImpl({required this.adversimentRemoteDatasource});
  @override
  Future<Either<Failure, List<AdvertisementModel>>> fetchAdversiments() async {
    try {
      return right(
        await adversimentRemoteDatasource.fetchAdversiments(),
      );
    } on ServerException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
