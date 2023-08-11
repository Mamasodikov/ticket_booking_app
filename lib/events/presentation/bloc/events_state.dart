part of 'events_bloc.dart';

@immutable
abstract class EventsState {}

class EventsInitial extends EventsState {}

class AuthFailureState extends EventsState {
  final String message;

  AuthFailureState({required this.message});
}

class NoInternetConnection extends EventsState {}

class EventsLoading extends EventsState {}

class GetEventsSuccess extends EventsState {
  final List<EventModel> resultList;

  GetEventsSuccess({required this.resultList});
}

class EventsSuccessState extends EventsState {
  final String message;

  EventsSuccessState({required this.message});
}

class EventsFailureState extends EventsState {
  final String message;

  EventsFailureState({required this.message});
}
