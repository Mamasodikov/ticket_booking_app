part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SendLoginEvent extends LoginEvent {
  final String email;
  final String password;

  SendLoginEvent(this.email, this.password);
}

class SendRegisterEvent extends LoginEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  SendRegisterEvent(this.firstName, this.lastName, this.email, this.username, this.password);
}

