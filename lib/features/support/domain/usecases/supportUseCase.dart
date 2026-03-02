import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/support/domain/entities/support.dart';
import 'package:qawafi_app/features/support/domain/repository/support_repository.dart';


class SentContactUseCase  {
  final ContactRepository repository;

SentContactUseCase({required this.repository});

  Future<Either<Failure, String>> call({required String fullName ,required String phoneNumber,required String email ,required String title ,required String description}) async {
    return await repository.SendContact(fullName,phoneNumber,email,title,description);
  }
}


