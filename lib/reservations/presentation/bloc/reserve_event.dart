part of 'reserve_bloc.dart';

@immutable
abstract class ReservesEvent {}

class GetReservesEvent extends ReservesEvent {
  final bool? fromLocal;

  GetReservesEvent({this.fromLocal});
}


class UpdateReserveEvent extends ReservesEvent {
  final int? id;
  final int? eventId;
  final int? count;

  UpdateReserveEvent({this.id, this.eventId, this.count});

}

class DeleteReserveEvent extends ReservesEvent {
  final int? id;

  DeleteReserveEvent({this.id});
}

class PayReserveEvent extends ReservesEvent {
  final int? id;

  PayReserveEvent({this.id});
}
