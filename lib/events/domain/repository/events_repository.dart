import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<EventModel>>> getReserves(
      String? text, bool? fromLocal);

  Future<Either<Failure, dynamic>> createEvent(
    EventCreateModel? event,
  );

  Future<Either<Failure, dynamic>> putEvent(
    EventCreateModel? event,
  );

  Future<Either<Failure, dynamic>> deleteEvent(
    EventModel? event,
  );

  Future<Either<Failure, dynamic>> reserveEvent(int? id, int? count);
}
