import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/ads/data/models/advertisement_model.dart';
import 'package:qawafi_app/features/ads/domain/repository/advertisement_repository.dart';

class FetchAdvertisement
    implements UseCase<List<AdvertisementModel>, NoParams> {
  final AdvertisementRepository advertisementRepository;

  FetchAdvertisement({required this.advertisementRepository});
  @override
  Future<Either<Failure, List<AdvertisementModel>>> call(
      NoParams params) async {
    return await advertisementRepository.fetchAdversiments();
  }
}
