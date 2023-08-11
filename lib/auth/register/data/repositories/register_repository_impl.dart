import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/network/network_info.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/auth/register/data/datasources/register_remote_datasources.dart';
import 'package:ticket_booking_app/auth/register/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterRemoteDatasourceImpl registerRemoteDatasource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl(
      {required this.registerRemoteDatasource,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> sendRegister(String firstName, String lastName, String email, String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await registerRemoteDatasource.setData( firstName,  lastName,  email,
             username,  password);

        if (result == "1") {
          return Right(result);
        } else if (result == "0") {
          return Left(ServerFailure(operationError));
        } else {
          return Right(result);
        }
      } on ServerFailure {
        return Left(ServerFailure(operationError));
      } on InputFormatterFailure {
        return const Left(InputFormatterFailure('failure'));
      } on FormatException {
        return Left(ServerFailure(incorrectData));
      }
    } else {
      return Left(NoConnectionFailure(checkInternet));
    }
  }

}