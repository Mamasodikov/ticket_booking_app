import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/network/network_info.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/reservations/data/datasources/reserves_local_datasources.dart';
import 'package:ticket_booking_app/reservations/data/datasources/reserves_remote_datasources.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';
import 'package:ticket_booking_app/reservations/domain/repository/reserves_repository.dart';

class ReservesRepositoryImpl extends ReservesRepository {
  final ReservesRemoteDatasourceImpl reservesRemoteDatasourceImpl;
  final ReservesLocalDataSourcesImpl reservesLocalDatasourceImpl;
  final NetworkInfo networkInfo;

  ReservesRepositoryImpl(
      {required this.reservesRemoteDatasourceImpl,
      required this.reservesLocalDatasourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<ReservationModel>>> getReserves(
      bool? fromLocal) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    var isFromLocal = fromLocal ?? false;

    if (await networkInfo.isConnected && !isFromLocal) {
      try {
        final result = await reservesRemoteDatasourceImpl.getReserves();

        if (result.runtimeType == List<ReservationModel>) {
          reservesLocalDatasourceImpl.setAllReserves(result);
          sharedPreferences.setString(reserveTime, time);
          return Right(result);
        } else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        } else if (result.runtimeType == AuthFailure) {
          result as AuthFailure;
          return Left(AuthFailure(result.message));
        } else {
          /// Fix here
          return Right([]);
        }
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await reservesLocalDatasourceImpl.getAllReserves();
        return Right(result);
      } on LocalFailure catch (e) {
        return Left(ServerFailure(downloadError));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteReserve(int? id) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await reservesRemoteDatasourceImpl.deleteReserve(id);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(reserveTime, time);
          return Right(result);
        } else if (result == "0") {
          return Left(ServerFailure(operationError));
        } else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        } else if (result.runtimeType == AuthFailure) {
          result as AuthFailure;
          return Left(AuthFailure(result.message));
        } else {
          ///Failure message
          return Right(result);
        }
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NoConnectionFailure(checkInternet));
    }
  }

  @override
  Future<Either<Failure, dynamic>> putReserve(
      int? id, int? eventId, int? count) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await reservesRemoteDatasourceImpl.updateReserve(
            id, eventId, count);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(reserveTime, time);
          return Right(result);
        } else if (result == "0") {
          return Left(ServerFailure(operationError));
        } else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        } else if (result.runtimeType == AuthFailure) {
          result as AuthFailure;
          return Left(AuthFailure(result.message));
        } else {
          ///Failure message
          return Right(result);
        }
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NoConnectionFailure(checkInternet));
    }
  }

  @override
  Future<Either<Failure, dynamic>> payReserve(int? id) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await reservesRemoteDatasourceImpl.payReserve(id);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(reserveTime, time);
          return Right(result);
        } else if (result == "0") {
          return Left(ServerFailure(operationError));
        } else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        } else if (result.runtimeType == AuthFailure) {
          result as AuthFailure;
          return Left(AuthFailure(result.message));
        } else {
          ///Failure message
          return Right(result);
        }
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NoConnectionFailure(checkInternet));
    }
  }
}
