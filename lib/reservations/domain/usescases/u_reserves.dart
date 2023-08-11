import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/usescases/usecase.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';
import 'package:ticket_booking_app/reservations/domain/repository/reserves_repository.dart';

class UReserves extends UseCase<dynamic, ReservesParams> {
  final ReservesRepository reservesRepository;

  UReserves({required this.reservesRepository});

  @override
  Future<Either<Failure, List<ReservationModel>>> call(ReservesParams params) {
    return reservesRepository.getReserves(params.fromLocal);
  }
}

class ReservesParams extends Equatable {
  final bool? fromLocal;

  ReservesParams({this.fromLocal});

  @override
  List<dynamic> get props => [fromLocal];
}

///********************************************************

class URUpdate extends UseCase<dynamic, UpdateRParams> {
  final ReservesRepository reservesRepository;

  URUpdate({required this.reservesRepository});

  @override
  Future<Either<Failure, dynamic>> call(UpdateRParams params) {
    return reservesRepository.putReserve(
        params.id, params.eventId, params.count);
  }
}

class UpdateRParams extends Equatable {
  final int? id;
  final int? eventId;
  final int? count;

  UpdateRParams({this.id, this.eventId, this.count});

  @override
  List<int?> get props => [id, eventId, count];
}

///********************************************************

class URDelete extends UseCase<dynamic, DeleteRParams> {
  final ReservesRepository reservesRepository;

  URDelete({required this.reservesRepository});

  @override
  Future<Either<Failure, dynamic>> call(DeleteRParams params) {
    return reservesRepository.deleteReserve(params.id);
  }
}

class DeleteRParams extends Equatable {
  final int? id;

  DeleteRParams({this.id});

  @override
  List<int?> get props => [id];
}

///********************************************************

class URPay extends UseCase<dynamic, PayRParams> {
  final ReservesRepository reservesRepository;

  URPay({required this.reservesRepository});

  @override
  Future<Either<Failure, dynamic>> call(PayRParams params) {
    return reservesRepository.payReserve(params.id);
  }
}

class PayRParams extends Equatable {
  final int? id;

  PayRParams({this.id});

  @override
  List<int?> get props => [id];
}
