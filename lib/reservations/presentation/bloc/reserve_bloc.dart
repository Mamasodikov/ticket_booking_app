import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';
import 'package:ticket_booking_app/reservations/domain/usescases/u_reserves.dart';

part 'reserve_state.dart';

part 'reserve_event.dart';

class ReservesBloc extends Bloc<ReservesEvent, ReservesState> {
  final UReserves reserves;
  final URUpdate update;
  final URDelete delete;
  final URPay pay;

  ReservesBloc({
    required this.update,
    required this.delete,
    required this.pay,
    required this.reserves,
  }) : super(ReservesInitial()) {
    on<GetReservesEvent>(getReserves, transformer: sequential());
    on<UpdateReserveEvent>(updateReserve, transformer: sequential());
    on<DeleteReserveEvent>(deleteReserve, transformer: sequential());
    on<PayReserveEvent>(payReserve, transformer: sequential());
  }

  FutureOr<void> getReserves(
      GetReservesEvent event, Emitter<ReservesState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(ReservesLoading());

    final result = await reserves(
      ReservesParams(fromLocal: event.fromLocal),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(ReservesFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            },
        (r) => {emit(GetReservesSuccess(resultList: r))});
  }

  FutureOr<void> updateReserve(
      UpdateReserveEvent event, Emitter<ReservesState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(ReservesLoading());

    final result = await update(
      UpdateRParams(id: event.id, eventId: event.eventId, count: event.count),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(ReservesFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(ReservesSuccessState(message: 'Success!'));
      } else {
        emit(ReservesFailureState(message: r));
      }
    });
  }

  FutureOr<void> deleteReserve(
      DeleteReserveEvent event, Emitter<ReservesState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(ReservesLoading());

    final result = await delete(
      DeleteRParams(
        id: event.id,
      ),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(ReservesFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(ReservesSuccessState(message: 'Success!'));
      } else {
        emit(ReservesFailureState(message: r));
      }
    });
  }

  FutureOr<void> payReserve(
      PayReserveEvent event, Emitter<ReservesState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(ReservesLoading());

    final result = await pay(
      PayRParams(id: event.id),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(ReservesFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(ReservesSuccessState(message: r));
      }
      else {
        emit(ReservesFailureState(message: r));
      }
    });
  }
}
