part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class NoConnectionLogin extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

class NoUser extends LoginState {}

class UserExist extends LoginState {}

class PasswordError extends LoginState {}

class ServerError extends LoginState {}

class LoginSuccess extends LoginState {}
