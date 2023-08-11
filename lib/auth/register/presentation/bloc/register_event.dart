part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class SendRegisterEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  SendRegisterEvent(this.firstName, this.lastName, this.email, this.username, this.password);
}

