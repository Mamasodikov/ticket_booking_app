import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/network/network_info.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/events/data/datasources/events_local_datasources.dart';
import 'package:ticket_booking_app/events/data/datasources/events_remote_datasources.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/domain/repository/events_repository.dart';

class EventsRepositoryImpl extends EventsRepository {
  final EventsRemoteDatasourceImpl eventsRemoteDatasourceImpl;
  final EventsLocalDataSourcesImpl eventsLocalDatasourceImpl;
  final NetworkInfo networkInfo;

  EventsRepositoryImpl(
      {required this.eventsRemoteDatasourceImpl,
      required this.eventsLocalDatasourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<EventModel>>> getReserves(
      String? text, bool? fromLocal) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    var isFromLocal = fromLocal ?? false;

    if (await networkInfo.isConnected && !isFromLocal) {
      try {
        final result = await eventsRemoteDatasourceImpl.getEvents(text);

        if (result.runtimeType == List<EventModel>) {
          eventsLocalDatasourceImpl.setAllEvents(result);
          sharedPreferences.setString(eventsTime, time);
          return Right(result);
        } else if (result.runtimeType == ServerFailure) {
          result as ServerFailure;
          return Left(ServerFailure(result.message));
        } else if (result.runtimeType == AuthFailure) {
          result as AuthFailure;
          return Left(AuthFailure(result.message));
        } else {

          ///TODO: Fix here
          return Right([]);
        }
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final result = await eventsLocalDatasourceImpl.getAllEvents();
        return Right(result);
      } on LocalFailure catch (e) {
        return Left(ServerFailure(downloadError));
      }
    }
  }

  @override
  Future<Either<Failure, dynamic>> createEvent(EventCreateModel? event) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await eventsRemoteDatasourceImpl.createEvent(event);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(eventsTime, time);
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
  Future<Either<Failure, dynamic>> deleteEvent(EventModel? event) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await eventsRemoteDatasourceImpl.deleteEvent(event);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(eventsTime, time);
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
  Future<Either<Failure, dynamic>> putEvent(EventCreateModel? event) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await eventsRemoteDatasourceImpl.updateEvent(event);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(eventsTime, time);
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
  Future<Either<Failure, dynamic>> reserveEvent(int? id, int? count) async {
    SharedPreferences sharedPreferences = di();

    var time = (DateFormat('dd-MM-yyyy  HH:mm:ss').format(DateTime.now()));

    if (await networkInfo.isConnected) {
      try {
        final result = await eventsRemoteDatasourceImpl.reserveEvent(id, count);

        if (result == "1") {
          ///Should set to local here (if we dont modify without net, better take online)
          sharedPreferences.setString(eventsTime, time);
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
