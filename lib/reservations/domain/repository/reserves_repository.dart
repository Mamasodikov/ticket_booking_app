import 'package:dartz/dartz.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

abstract class ReservesRepository {
  Future<Either<Failure, List<ReservationModel>>> getReserves(bool? fromLocal);

  Future<Either<Failure, dynamic>> putReserve(
      int? id, int? eventId, int? count);

  Future<Either<Failure, dynamic>> deleteReserve(int? id);

  Future<Either<Failure, dynamic>> payReserve(int? id);
}
