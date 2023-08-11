import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_cookie_jar/sweet_cookie_jar.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/functions.dart';
import 'package:ticket_booking_app/core/utils/api_path.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';

abstract class LoginRemoteDatasource {
  Future<dynamic> setData(String email, String password);
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final http.Client client;
  SharedPreferences prefs = di();

  LoginRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> setData(String email, String password) async {
    try {
      var body = {
        "username": email,
        "password": password,
      };

      var response = await client.post(
        Uri.parse(baseUrl + loginPAth),
        body: jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        SweetCookieJar sweetCookieJar = SweetCookieJar.from(response: response);
        Cookie csrftoken = sweetCookieJar.find(name: 'csrftoken');
        Cookie sessionid = sweetCookieJar.find(name: 'sessionid');

        if (csrftoken.isNotEmpty && sessionid.isNotEmpty) {
          print('Csrf-Token: ${csrftoken.value}');
          print('Session-ID: ${sessionid.value}');
          prefs.setString('token', csrftoken.value);
          prefs.setString('session', sessionid.value);
          return "1";
        } else
          return "0";

        // var headersList = response.headers['set-cookie']!.split(";");
        // for (var kvPair in headersList) {
        //   var kv = kvPair.split("=");
        //   var key = kv[0];
        //   var value = kv[1];
        //
        //   if (key.contains("csrftoken") && value.isNotEmpty) {
        //     print(value);
        //     prefs.setString('token', value);
        //     return "1";
        //   } else
        //     return "0";
        // }
      } else if (response.statusCode == 400) {
        final parsed = await json.decode(response.body) as Map<String, dynamic>;
        if (parsed.containsKey('email')) {
          var list = parsed['email'];
          var message = buildStringWithNewlines(list);
          print(message);
          return message;
        } else if (parsed.containsKey('detail')) {
          var list = parsed['detail'];
          var message = buildStringWithNewlines(list);
          print(message);
          return message;
        } else if (parsed.containsKey('password')) {
          var list = parsed['password'];
          var message = buildStringWithNewlines(list);
          print(message);
          return message;
        } else
          return response.body.toString();
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
      return ServerFailure(e.toString());
    }
  }
}
