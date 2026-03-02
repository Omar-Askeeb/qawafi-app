import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qawafi_app/core/error/failures.dart';
import 'package:qawafi_app/core/network/connection_checker.dart';
import 'package:qawafi_app/features/support/data/datasource/support_remote_data_source.dart';
import 'package:qawafi_app/features/support/data/models/support.dart';
import 'package:qawafi_app/features/support/domain/entities/support.dart';
import 'package:qawafi_app/features/support/domain/repository/support_repository.dart';
import 'package:qawafi_app/features/support/presentation/bloc/contact_bloc.dart';


class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, String>> SendContact(String fullName, String phoneNumber, String email, String title, String description)async {
 try {
        final isConnected = await ConnectionCheckerImpl(InternetConnection()).isConnected; 
    if (!isConnected) {
      // في حالة عدم الاتصال، ارجاع خطأ الاتصال بالإنترنت
      return left(Failure('لا يوجد إتصال بالأنترنت'));
    }
      final res = await remoteDataSource.SendContact(fullName,phoneNumber,email,title,description);
      return Right(res);
    } catch (exception) {
      return Left(Failure( exception.toString()));
    }
  }
}
