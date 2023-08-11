import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, dynamic>> sendRegister(String firstName,
      String lastName, String email, String username, String password);
}
