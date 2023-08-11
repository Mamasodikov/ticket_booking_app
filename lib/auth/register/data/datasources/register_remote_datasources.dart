import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/errors/failures.dart';
import 'package:ticket_booking_app/core/functions.dart';
import 'package:ticket_booking_app/core/utils/api_path.dart';

abstract class RegisterRemoteDatasource {
  Future<dynamic> setData(String firstName, String lastName, String email,
      String username, String password);
}

class RegisterRemoteDatasourceImpl implements RegisterRemoteDatasource {
  final http.Client client;
  SharedPreferences prefs = di();

  RegisterRemoteDatasourceImpl({required this.client});

  @override
  Future<dynamic> setData(String firstName, String lastName, String email,
      String username, String password) async {
    try {
      var body = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "password": password,
        "password1": password
      };

      var response = await client.post(
        Uri.parse(baseUrl + registerPath),
        body: jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      // print(response.body);

      if (response.statusCode == 201) {
        return "1";
      } else if (response.statusCode == 200) {
        final parsed = await json.decode(response.body) as Map<String, dynamic>;
        if (parsed.containsKey('email')) {
          var list = parsed['email'];
          var message = buildStringWithNewlines(list);
          return message;
        } else if (parsed.containsKey('detail')) {
          var list = parsed['detail'];
          var message = buildStringWithNewlines(list);
          return message;
        } else if (parsed.containsKey('password')) {
          var list = parsed['password'];
          var message = buildStringWithNewlines(list);
          print(message);
          return message;
        } else
          return 'Unknown Failure';
      } else {
        return "0";
      }
    } on FormatException {
      return FormatException('failure');
    } on InputFormatterFailure {
      return InputFormatterFailure('failure');
    } on ServerFailure {
      return ServerFailure("Маълумот юкланишда хатолик бўлди");
    }
  }
}
