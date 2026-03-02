import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/common/models/user_info.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

import '../../../auth/domain/usecases/refresh_token.dart';

class Subscribe implements UseCase<UserInfoModel, SubscribeParams> {
  final CustomerRepository repository;
  final RefreshToken refreshToken;
  final LocalStorage localStorage;

  Subscribe({
    required this.repository,
    required this.refreshToken,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, UserInfoModel>> call(SubscribeParams params) async {
    var res = await repository.subscribe(
      userId: params.userId,
      subscriptionId: params.subscriptionId,
    );

    log('Refresh Token:' + (await localStorage.refreshToken));
    return res.fold(
      (l) => left(l),
      (r) async {
        return await refreshToken(
          RereshTokenParams(token: await localStorage.refreshToken),
        );
      },
    );
  }
}

class SubscribeParams {
  final String userId;
  final int subscriptionId;

  SubscribeParams({
    required this.userId,
    required this.subscriptionId,
  });
}
