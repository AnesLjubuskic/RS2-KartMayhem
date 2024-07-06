import 'dart:convert';
import 'package:kartmayhem_mobile/Models/korisnik.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  static String? _baseUrl;
  KorisnikProvider() : super("Korisnici") {
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

  Future<bool?> editUser(int id, [dynamic request]) {
    var url = "$_baseUrl" "Korisnici/editUser/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!
        .put(uri, headers: headers, body: jsonEncode(request))
        .then((response) {
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body);
          throw Exception("${data["errors"]["userError"][0].toString()}");
        }
        throw Exception('Something went wrong!');
      }
    });
  }
}
