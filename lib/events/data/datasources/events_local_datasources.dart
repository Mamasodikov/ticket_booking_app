import 'package:isar/isar.dart';
import 'package:ticket_booking_app/core/database/isar_service.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

abstract class EventsLocalDataSources {
  Future<List<EventModel>> getAllEvents();

  Future<bool> setAllEvents(List<EventModel> list);

  Future<bool> createEvent(EventModel event);

  Future<bool> updateEvent(EventModel event);

  Future<bool> deleteEvent(EventModel event);

  Future<bool> createReservation(ReservationModel reserve);
}

class EventsLocalDataSourcesImpl extends EventsLocalDataSources {
  final IsarService isarService = di();

  @override
  Future<List<EventModel>> getAllEvents() async {
    List<EventModel> list = [];

    list = await isarService.isar.eventModels.where().findAll();

    return list;
  }

  @override
  Future<bool> setAllEvents(List<EventModel> list) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.eventModels.clear();
      });
      await isarService.isar.writeTxn(() async {
        isarService.isar.eventModels.putAll(list);
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createEvent(EventModel event) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.eventModels.put(event);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> createReservation(ReservationModel reserve) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.reservationModels.put(reserve);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteEvent(EventModel event) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.eventModels.delete(event.localId);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateEvent(EventModel event) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.eventModels.put(event);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
