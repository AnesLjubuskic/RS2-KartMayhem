import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/src/response.dart';
import 'package:kartmayhem_mobile/Models/korisnik.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class AuthProvider extends BaseProvider<Korisnik> {
  static int? _loggedUserId = 0;

  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  AuthProvider() : super("Auth") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:8080/");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  void setParameters(
    int loggedUserId,
  ) {
    _loggedUserId = loggedUserId;
  }

  int getLoggedUserId() {
    return _loggedUserId!.toInt();
  }

  Future<Korisnik?> login(dynamic request) async {
    var url = "$_baseUrl" "Auth/login";

    var headers = createHeaders();
    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<Korisnik?> register(dynamic request) async {
    var url = "$_baseUrl" "Auth/register";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);
    if (isValidResponseCodeRegister(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        throw Exception("${data["errors"]["userError"][0].toString()}");
      }

      throw Exception('Something went wrong!');
    }
  }

  void logout() {
    _loggedUserId = 0;
  }

  @override
  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        if (data['errors'] != null && !data['errors'].isEmpty) {
          var errorData = data["errors"] as Map<dynamic, dynamic>;
          var firstKey = errorData.keys.toList().first;
          var errorString = data['errors'][firstKey];
          throw Exception("Bad request $errorString");
        }
        throw Exception('Bad request');
      }
      throw Exception('Empty 400 response');
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  bool isValidResponseCodeRegister(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
