import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';

import '../widgets/custom_toast.dart';

class APIService<T> {
  final Uri? url;
  final dynamic body;
  final List<dynamic>? files;
  final T Function(http.Response response) parse;

  APIService({this.url, this.body, required this.parse, this.files});
}

class APIWeb {
  final http.Client client = di();
  final SharedPreferences prefs = di();

  Future<T> load<T>(APIService<T> resource) async {
    final response = await http.get(resource.url!);
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<T> post<T>(APIService<T> resource) async {
    try {
      final response = await client.post(resource.url!,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer ${prefs.getString("token")}"
          },
          body: jsonEncode(resource.body));

      if (response.statusCode == 200) {
        // CustomToast.showToast(response.body);
        return resource.parse(response);
      } else {
        print(response.body);
        CustomToast.showToast(response.body);
        throw Exception(response.statusCode);
      }
    } on Exception catch (e) {
      // CustomToast.showToast(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<T> get<T>(APIService<T> resource) async {
    try {
      final response =
          await client.get(resource.url!, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": "Bearer ${prefs.getString("token")}"
      });

      if (response.statusCode == 200) {
        // CustomToast.showToast(response.body);
        return resource.parse(response);
      } else {
        print(response.body);
        CustomToast.showToast(response.body);
        throw Exception(response.statusCode);
      }
    } on Exception catch (e) {
      // CustomToast.showToast(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<T> put<T>(APIService<T> resource) async {
    try {
      final response = await client.put(resource.url!,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            "Authorization": "Bearer ${prefs.getString("token")}"
          },
          body: jsonEncode(resource.body));

      if (response.statusCode == 200) {
        // CustomToast.showToast(response.body);
        return resource.parse(response);
      } else {
        CustomToast.showToast(response.body);
        throw Exception(response.statusCode);
      }
    } on Exception catch (e) {
      // CustomToast.showToast(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<T> putFormData<T>(APIService<T> resource) async {
    var request = http.MultipartRequest("PUT", resource.url!);

    request.headers["Content-Type"] = "multipart/form-data";
    request.headers["Authorization"] = "Bearer ${prefs.getString("token")}";

    resource.body.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    resource.files?.forEach((element) async {
      if (element != null) {
        final file = await http.MultipartFile.fromPath('files', element.path,
            contentType: MediaType('image', 'jpeg'));
        request.files.add(file);
      } else {
        request.files.clear();
      }
    });

    final data = await request.send();
    final response = await http.Response.fromStream(data);
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else if (response.statusCode == 404) {
      CustomToast.showToast('404 Error');
      return Future.value();
    } else if (response.statusCode == 400) {
      CustomToast.showToast('400 Error');
      return Future.value();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
