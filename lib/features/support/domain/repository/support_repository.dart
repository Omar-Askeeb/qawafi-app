import 'package:fpdart/fpdart.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/features/support/domain/entities/support.dart';

abstract class ContactRepository {
  Future<Either<Failure, String>> SendContact(String fullName , String phoneNumber,String email ,String title ,String description);
}
