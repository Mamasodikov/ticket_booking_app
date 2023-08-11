import 'package:isar/isar.dart';
import 'package:ticket_booking_app/core/database/isar_service.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

abstract class ReservesLocalDataSources {
  Future<List<ReservationModel>> getAllReserves();

  Future<bool> setAllReserves(List<ReservationModel> list);

  Future<bool> updateReserve(ReservationModel event);

  Future<bool> deleteReserve(ReservationModel event);

  Future<bool> payReserve(ReservationModel reserve);
}

class ReservesLocalDataSourcesImpl extends ReservesLocalDataSources {
  final IsarService isarService = di();

  @override
  Future<List<ReservationModel>> getAllReserves() async {
    List<ReservationModel> list = [];

    list = await isarService.isar.reservationModels.where().findAll();

    return list;
  }

  @override
  Future<bool> setAllReserves(List<ReservationModel> list) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.reservationModels.clear();
      });
      await isarService.isar.writeTxn(() async {
        isarService.isar.reservationModels.putAll(list);
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteReserve(ReservationModel reserve) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.reservationModels.delete(reserve.localId);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateReserve(ReservationModel reserve) async {
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
  Future<bool> payReserve(ReservationModel reserve) async {
    try {
      await isarService.isar.writeTxn(() async {
        await isarService.isar.reservationModels.put(reserve);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
