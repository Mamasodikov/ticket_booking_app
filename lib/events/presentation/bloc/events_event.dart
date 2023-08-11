part of 'events_bloc.dart';

@immutable
abstract class EventsEvent {}

class GetEventsEvent extends EventsEvent {
  final String? text;
  final bool? fromLocal;

  GetEventsEvent({this.fromLocal, this.text});
}

class CreateEvent extends EventsEvent {
  final EventCreateModel? event;

  CreateEvent({this.event});
}

class UpdateEvent extends EventsEvent {
  final EventCreateModel? event;

  UpdateEvent({this.event});
}

class DeleteEvent extends EventsEvent {
  final EventModel? event;

  DeleteEvent({this.event});
}

class ReserveEvent extends EventsEvent {
  final int? id;
  final int? count;

  ReserveEvent({this.id, this.count});
}
