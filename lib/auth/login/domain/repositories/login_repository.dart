import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, dynamic>> sendLogin(String email, String password);
}
