import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/usescases/usecase.dart';
import 'package:ticket_booking_app/auth/login/domain/repositories/login_repository.dart';

class LoginData extends UseCase<dynamic, LoginParams> {
  final LoginRepository loginRepository;

  LoginData({required this.loginRepository});

  @override
  Future<Either<Failure, dynamic>> call(LoginParams params) {
    return loginRepository.sendLogin(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  const LoginParams(
    this.email,
    this.password,
  );
}
