import 'dart:convert';

import 'package:kartmayhem_desktop/Models/staze.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class StazeProvider extends BaseProvider<Staze> {
  static String? _baseUrl;
  StazeProvider() : super("Staze") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Staze fromJson(data) {
    return Staze.fromJson(data);
  }

  Future<bool> deactivateTrack(int id) {
    var url = "$_baseUrl" "Staze/deactivateTrack/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!.put(uri, headers: headers).then((response) {
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body);
          throw Exception("${data["errors"]["stazeError"][0].toString()}");
        }

        throw Exception('Something went wrong!');
      }
    });
  }
}
