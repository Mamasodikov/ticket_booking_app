import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/network/network_info.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/auth/login/data/datasources/login_remote_datasources.dart';
import 'package:ticket_booking_app/auth/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasourceImpl loginRemoteDatasource;

  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.loginRemoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> sendLogin(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await loginRemoteDatasource.setData(email, password);

        if (result == "1") {
          return Right(result);
        } else if (result == "0") {
          return Left(ServerFailure(operationError));
        }
        else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        }
        else {
          return Right(result);
        }
      } on ServerFailure catch (e){
        return Left(ServerFailure(e.message));
      } on InputFormatterFailure  catch (e){
        return const Left(InputFormatterFailure('failure'));
      } on FormatException catch (e){
        return Left(ServerFailure(incorrectData));
      }
    } else {
      return Left(NoConnectionFailure(checkInternet));
    }
  }
}
