import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/usescases/usecase.dart';
import 'package:ticket_booking_app/auth/register/domain/repositories/register_repository.dart';

class RegisterData extends UseCase<dynamic, RegisterParams> {
  final RegisterRepository registerRepository;

  RegisterData({required this.registerRepository});

  @override
  Future<Either<Failure, dynamic>> call(RegisterParams params) {
    return registerRepository.sendRegister(params.firstName, params.lastName,
        params.email, params.username, params.password);
  }
}

class RegisterParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  RegisterParams(
      this.firstName, this.lastName, this.email, this.username, this.password);

  @override
  List<Object?> get props => [firstName, lastName, email, username, password];
}
