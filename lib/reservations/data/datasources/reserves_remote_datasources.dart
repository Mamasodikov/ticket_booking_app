import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/functions.dart';
import 'package:ticket_booking_app/core/utils/api_path.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

abstract class ReservesRemoteDatasource {
  Future<dynamic> getReserves();

  Future<dynamic> updateReserve(int? id, int? eventId, int? count);

  Future<dynamic> deleteReserve(int? id);

  Future<dynamic> payReserve(int? id);
}

class ReservesRemoteDatasourceImpl extends ReservesRemoteDatasource {
  final SharedPreferences prefs;
  final Dio dio;

  ReservesRemoteDatasourceImpl({required this.prefs, required this.dio});

  @override
  Future<dynamic> getReserves() async {
    List<ReservationModel> events = [];

    try {
      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.get(
        baseUrl + getAllReservesPath,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'X-CSRFTOKEN': token,
            'Cookie': 'csrftoken=$token; sessionid=$sessionid',
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data;
        for (int i = 0; i < (data ?? []).length; i++) {
          var work = ReservationModel.fromJson(data?[i]);
          events.add(work);
        }
        print("Received count: " + events.length.toString());
        return events;
      } else {
        print(events);
        return ServerFailure('Something went wrong!');
      }
    } on InputFormatterFailure catch (e) {
      return ServerFailure("Input Formatter Error");
    } on FormatException catch (e) {
      // handle the format exception
      print('Error: $e');
      CustomToast.showToast('Error: $e');
      return ServerFailure(e.toString());
    } catch (e) {
      // handle other exceptions
      if (e is DioError) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          final parsed = e.response?.data;
          if (parsed.containsKey('detail')) {
            var list = parsed['detail'];
            var message = buildStringWithNewlines(list);
            print(message);
            return message;
          } else
            return 'Unknown Failure';
        } else if (e.response?.statusCode == 403) {
          return AuthFailure(e.toString());
        } else {
          return "0";
        }
      }
      print('Error: $e');
      CustomToast.showToast('Error: $e');
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> deleteReserve(int? id) async {
    try {
      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.delete(
        baseUrl + reservesPath + id.toString() + cancelPath,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'X-CSRFTOKEN': token,
            'Cookie': 'csrftoken=$token; sessionid=$sessionid',
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 204) {
        return "1";
      } else {
        return "0";
      }
    } on FormatException catch (e) {
      return FormatException('failure');
    } on InputFormatterFailure catch (e) {
      return InputFormatterFailure('failure');
    } on ServerFailure catch (e) {
      return ServerFailure(operationError);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          final parsed = e.response?.data;
          if (parsed.containsKey('detail')) {
            var list = parsed['detail'];
            var message = buildStringWithNewlines(list);
            print(message);
            return message;
          } else
            return e.response?.data.toString();
        } else if (e.response?.statusCode == 403) {
          return AuthFailure(e.toString());
        } else {
          return "0";
        }
      }
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> updateReserve(int? id, int? eventId, int? count) async {
    try {
      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      ///TODO: Can edit some of them
      var headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFTOKEN': token,
        'Cookie': 'csrftoken=$token; sessionid=$sessionid'
      };

      var body = {
        "event": eventId,
        "number_of_tickets": count,
      };
      print(body);

      var data = FormData.fromMap(body);

      final response = await dio.put(
        baseUrl + reservesPath + id.toString() + updatePath,
        data: data,
        options: Options(
          headers: headers,
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return "1";
      } else {
        return "0";
      }
    } on FormatException catch (e) {
      return FormatException('failure');
    } on InputFormatterFailure catch (e) {
      return InputFormatterFailure('failure');
    } on ServerFailure catch (e) {
      return ServerFailure(operationError);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          final parsed = e.response?.data;
          if (parsed.containsKey('detail')) {
            var list = parsed['detail'];
            var message = buildStringWithNewlines(list);
            print(message);
            return message;
          } else
            return e.response?.data.toString();
        } else if (e.response?.statusCode == 403) {
          return AuthFailure(e.toString());
        } else {
          return "0";
        }
      }
      return ServerFailure(e.toString());
    }
  }

  @override
  Future<dynamic> payReserve(int? id) async {
    try {
      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.put(
        baseUrl + reservesPath + id.toString() + payPath,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'X-CSRFTOKEN': token,
            'Cookie': 'csrftoken=$token; sessionid=$sessionid',
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        final parsed = response.data;
        var list = parsed['message'];
        var message = buildStringWithNewlines(list);
        return message;
      } else {
        return "0";
      }
    } on FormatException catch (e) {
      return FormatException('failure');
    } on InputFormatterFailure catch (e) {
      return InputFormatterFailure('failure');
    } on ServerFailure catch (e) {
      return ServerFailure(operationError);
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 400 || e.response?.statusCode == 404) {
          final parsed = e.response?.data;
          if (parsed.containsKey('detail')) {
            var list = parsed['detail'];
            var message = buildStringWithNewlines(list);
            print(message);
            return message;
          } else
            return e.response?.data.toString();
        } else if (e.response?.statusCode == 403) {
          return AuthFailure(e.toString());
        } else {
          return "0";
        }
      }
      return ServerFailure(e.toString());
    }
  }
}
