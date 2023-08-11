import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/functions.dart';
import 'package:ticket_booking_app/core/utils/api_path.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';

abstract class EventsRemoteDatasource {
  Future<dynamic> getEvents(String? search);

  Future<dynamic> createEvent(EventCreateModel? event);

  Future<dynamic> updateEvent(EventCreateModel? event);

  Future<dynamic> deleteEvent(EventModel? event);

  Future<dynamic> reserveEvent(int? id, int? count);
}

class EventsRemoteDatasourceImpl extends EventsRemoteDatasource {
  final SharedPreferences prefs;

  final Dio dio;

  EventsRemoteDatasourceImpl({required this.prefs, required this.dio});

  @override
  Future<dynamic> getEvents(
    String? search,
  ) async {
    List<EventModel> events = [];

    try {
      Map<String, dynamic> body = {};

      if (search != null) {
        body['search'] = search;
      }

      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.get(baseUrl + getAllEventsSearchPath,
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'X-CSRFTOKEN': token,
              'Cookie': 'csrftoken=$token; sessionid=$sessionid',
            },
          ),
          queryParameters: body);

      if (response.statusCode == 200) {
        var data = response.data;
        for (int i = 0; i < (data ?? []).length; i++) {
          var work = EventModel.fromJson(data?[i]);
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
  Future<dynamic> createEvent(EventCreateModel? event) async {
    try {
      var body = {
        "name": event?.name,
        "topic": event?.topic,
        "date": event?.date,
        "place": event?.place,
        "number_of_seats": event?.numberOfSeats,
        "ticket_price": event?.ticketPrice,
        "currency": event?.currency,
        "thumbnail": await MultipartFile.fromFile(event?.thumbnail?.path ?? '',
            filename: event?.thumbnail?.path.split('/').last),
        "description": event?.description
      };

      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      var data = FormData.fromMap(body);

      final response = await dio.post(
        baseUrl + createEventPath,
        data: data,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'multipart/form-data',
            'X-CSRFTOKEN': token,
            'Cookie': 'csrftoken=$token; sessionid=$sessionid',
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 201) {
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
  Future<dynamic> deleteEvent(EventModel? event) async {
    try {
      var id = event?.id ?? 999;

      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.delete(
        baseUrl + eventsPath + id.toString() + deletePath,
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
  Future<dynamic> reserveEvent(int? id, int? count) async {
    try {
      var body = {"event": id, "number_of_tickets": count};

      var token = prefs.getString("token") ?? '';
      var sessionid = prefs.getString("session") ?? '';

      final response = await dio.post(
        baseUrl + createReservePath,
        data: body,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'X-CSRFTOKEN': token,
            'Cookie': 'csrftoken=$token; sessionid=$sessionid',
          },
        ),
      );

      print(response.data);

      if (response.statusCode == 201) {
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
  Future<dynamic> updateEvent(EventCreateModel? event) async {
    try {
      var id = event?.id;

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
        "name": event?.name,
        "topic": event?.topic,
        "date": event?.date,
        "place": event?.place,
        "number_of_seats": event?.numberOfSeats,
        "ticket_price": event?.ticketPrice,
        "currency": event?.currency,
        "thumbnail": await MultipartFile.fromFile(event?.thumbnail?.path ?? '',
            filename: event?.thumbnail?.path.split('/').last),
        "description": event?.description
      };
      print(body);

      var data = FormData.fromMap(body);

      final response = await dio.put(
        baseUrl + eventsPath + id.toString() + updatePath,
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
}
