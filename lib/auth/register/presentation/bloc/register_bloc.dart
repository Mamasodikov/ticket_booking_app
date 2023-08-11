import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/auth/register/domain/usescases/u_login.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterData registerData;

  RegisterBloc({required this.registerData}) : super(RegisterInitial()) {
    on<SendRegisterEvent>(_sendRegister, transformer: sequential());
  }

  FutureOr<void> _sendRegister(
      SendRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    final result = await registerData(
      RegisterParams(event.firstName, event.lastName, event.email,
          event.username, event.password),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                emit(NoConnectionRegister())
              else if (failure is RegisterFailure)
                emit(RegisterFailure(failure.message))
              else if (failure is ServerFailure)
                emit(ServerError())
              else if (failure is InputFormatterFailure)
                emit(ServerError())
            }, (r) {
      if (r == "1") {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(r));
      }
    });
  }
}
