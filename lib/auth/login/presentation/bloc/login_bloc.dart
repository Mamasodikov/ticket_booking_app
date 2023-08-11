import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/auth/login/domain/usescases/u_login.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginData loginData;

  LoginBloc({required this.loginData}) : super(LoginInitial()) {
    on<SendLoginEvent>(_sendLogin, transformer: sequential());
  }

  FutureOr<void> _sendLogin(
      SendLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final result = await loginData(
      LoginParams(event.email, event.password),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                emit(NoConnectionLogin())
              else if (failure is LoginFailure)
                emit(LoginFailure(failure.message))
              else if (failure is ServerFailure)
                emit(ServerError())
              else if (failure is InputFormatterFailure)
                emit(ServerError())
            }, (r) {
      if (r == "1") {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(r));
      }
    });
  }
}
