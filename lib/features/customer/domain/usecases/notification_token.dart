import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

class PutNotificationToken
    implements UseCase<void, PutNotificationTokenParams> {
  final CustomerRepository repository;

  PutNotificationToken({required this.repository});
  @override
  Future<Either<Failure, void>> call(PutNotificationTokenParams params) async {
    return await repository.notificationToken(token: params.token);
  }
}

class PutNotificationTokenParams {
  final String token;

  PutNotificationTokenParams({required this.token});
}
