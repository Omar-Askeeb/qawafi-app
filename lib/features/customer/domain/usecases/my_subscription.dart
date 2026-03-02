import 'dart:convert';

import 'package:fpdart/src/either.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/localStorage/loacal_storage.dart';
import 'package:qawafi_app/core/usecase/usecase.dart';
import 'package:qawafi_app/features/customer/domain/repository/customer_repository.dart';

import '../../../../core/usecase/string_param.dart';
import '../../data/models/subscription_model.dart';

class MySubscription implements UseCase<SubscriptionModel, StringParam> {
  final CustomerRepository repository;
  final LocalStorage localStorage;

  MySubscription({
    required this.repository,
    required this.localStorage,
  });

  @override
  Future<Either<Failure, SubscriptionModel>> call(StringParam params) async {
    var res = await repository.mySubscription(userId: params.string);
    res.fold(
      (l) => null,
      (r) => localStorage.storeMySubscription(
        jsonEncode(
          r.toJson(),
        ),
      ),
    );

    return res;
  }
}
