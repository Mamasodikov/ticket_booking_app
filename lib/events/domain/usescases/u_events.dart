import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/usescases/usecase.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/domain/repository/events_repository.dart';

class UEvents extends UseCase<dynamic, EventsParams> {
  final EventsRepository eventsRepository;

  UEvents({required this.eventsRepository});

  @override
  Future<Either<Failure, List<EventModel>>> call(EventsParams params) {
    return eventsRepository.getReserves(params.text, params.fromLocal);
  }
}

class EventsParams extends Equatable {
  final String? text;
  final bool? fromLocal;

  EventsParams({this.text, this.fromLocal});

  @override
  List<dynamic> get props => [text, fromLocal];
}

///********************************************************

class UCreate extends UseCase<dynamic, CreateParams> {
  final EventsRepository eventsRepository;

  UCreate({required this.eventsRepository});

  @override
  Future<Either<Failure, dynamic>> call(CreateParams params) {
    return eventsRepository.createEvent(params.event);
  }
}

class CreateParams extends Equatable {
  final EventCreateModel? event;

  CreateParams({this.event});

  @override
  List<EventCreateModel?> get props => [event];
}

///********************************************************

class UUpdate extends UseCase<dynamic, UpdateParams> {
  final EventsRepository eventsRepository;

  UUpdate({required this.eventsRepository});

  @override
  Future<Either<Failure, dynamic>> call(UpdateParams params) {
    return eventsRepository.putEvent(params.event);
  }
}

class UpdateParams extends Equatable {
  final EventCreateModel? event;

  UpdateParams({this.event});

  @override
  List<EventCreateModel?> get props => [event];
}

///********************************************************

class UDelete extends UseCase<dynamic, DeleteParams> {
  final EventsRepository eventsRepository;

  UDelete({required this.eventsRepository});

  @override
  Future<Either<Failure, dynamic>> call(DeleteParams params) {
    return eventsRepository.deleteEvent(params.event);
  }
}

class DeleteParams extends Equatable {
  final EventModel? event;

  DeleteParams({this.event});

  @override
  List<EventModel?> get props => [event];
}

///********************************************************

class UReserve extends UseCase<dynamic, ReserveParams> {
  final EventsRepository eventsRepository;

  UReserve({required this.eventsRepository});

  @override
  Future<Either<Failure, dynamic>> call(ReserveParams params) {
    return eventsRepository.reserveEvent(params.id, params.count);
  }
}

class ReserveParams extends Equatable {
  final int? id;
  final int? count;

  ReserveParams({this.id, this.count});

  @override
  List<int?> get props => [id, count];
}
