import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/ads/data/models/advertisement_model.dart';

abstract interface class AdvertisementRepository {
  Future<Either<Failure, List<AdvertisementModel>>> fetchAdversiments();
}
