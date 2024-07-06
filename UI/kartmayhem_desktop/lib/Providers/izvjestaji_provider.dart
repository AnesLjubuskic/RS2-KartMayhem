import 'dart:convert';

import 'package:kartmayhem_desktop/Models/izvjestaji.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class IzvjestajiProvider extends BaseProvider<Izvjestaji> {
  static String? _baseUrl;
  IzvjestajiProvider() : super("Izvjestaj") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Izvjestaji fromJson(data) {
    return Izvjestaji.fromJson(data);
  }

  Future<Izvjestaji> getIzvjestaj({dynamic search}) async {
    var url = "$_baseUrl" "Izvjestaj/izvjestaji";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }
    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
