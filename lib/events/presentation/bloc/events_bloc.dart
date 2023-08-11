import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/domain/usescases/u_events.dart';

part 'events_state.dart';

part 'events_event.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final UEvents events;
  final UCreate create;
  final UUpdate update;
  final UDelete delete;
  final UReserve reserve;

  EventsBloc({
    required this.create,
    required this.update,
    required this.delete,
    required this.reserve,
    required this.events,
  }) : super(EventsInitial()) {
    on<GetEventsEvent>(getEvents, transformer: sequential());
    on<CreateEvent>(createEvent, transformer: sequential());
    on<UpdateEvent>(updateEvent, transformer: sequential());
    on<DeleteEvent>(deleteEvent, transformer: sequential());
    on<ReserveEvent>(reserveEvent, transformer: sequential());
  }

  FutureOr<void> getEvents(
      GetEventsEvent event, Emitter<EventsState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(EventsLoading());

    final result = await events(
      EventsParams(text: event.text, fromLocal: event.fromLocal),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(EventsFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            },
        (r) => {emit(GetEventsSuccess(resultList: r))});
  }

  FutureOr<void> createEvent(
      CreateEvent event, Emitter<EventsState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(EventsLoading());

    final result = await create(
      CreateParams(
        event: event.event,
      ),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(EventsFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(EventsSuccessState(message: 'Success!'));
      } else {
        emit(EventsFailureState(message: r));
      }
    });
  }

  FutureOr<void> updateEvent(
      UpdateEvent event, Emitter<EventsState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(EventsLoading());

    final result = await update(
      UpdateParams(
        event: event.event,
      ),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(EventsFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(EventsSuccessState(message: 'Success!'));
      } else {
        emit(EventsFailureState(message: r));
      }
    });
  }

  FutureOr<void> deleteEvent(
      DeleteEvent event, Emitter<EventsState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(EventsLoading());

    final result = await delete(
      DeleteParams(
        event: event.event,
      ),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(EventsFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(EventsSuccessState(message: 'Success!'));
      } else {
        emit(EventsFailureState(message: r));
      }
    });
  }

  FutureOr<void> reserveEvent(
      ReserveEvent event, Emitter<EventsState> emit) async {
    ///Don't emit Loading state unconditionally when using Bloc with infinitive_list_view (package handles all itself)

    emit(EventsLoading());

    final result = await reserve(
      ReserveParams(id: event.id, count: event.count),
    );

    result.fold(
        (failure) => {
              if (failure is NoConnectionFailure)
                {emit(NoInternetConnection())}
              else if (failure is ServerFailure)
                {emit(EventsFailureState(message: failure.message))}
              else if (failure is AuthFailure)
                {emit(AuthFailureState(message: failure.message))}
            }, (r) {
      if (r == "1") {
        emit(EventsSuccessState(message: 'Success!'));
      } else {
        emit(EventsFailureState(message: r));
      }
    });
  }
}
