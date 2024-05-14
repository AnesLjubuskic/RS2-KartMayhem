import 'dart:convert';
import 'package:kartmayhem_desktop/Models/korisnik.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class KorisnikProvider extends BaseProvider<Korisnik> {
  static String? _baseUrl;
  KorisnikProvider() : super("Korisnici") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44338/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Korisnik fromJson(data) {
    return Korisnik.fromJson(data);
  }

  Future<List<Korisnik>?> gettopkorisnike() async {
    var url = "$_baseUrl" "Korisnici/topUsers";
    var headers = createHeaders();
    var uri = Uri.parse(url);
    var response = await http!.get(uri, headers: headers);
    print(response);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      print(data);
      var topUsers = data.map<Korisnik>((x) => fromJson(x)).toList();
      return topUsers;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<bool> awardUser(int id) {
    var url = "$_baseUrl" "Korisnici/rewardUser/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!.put(uri, headers: headers).then((response) {
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    });
  }

  Future<bool> cancelUserAward(int id) {
    var url = "$_baseUrl" "Korisnici/cancelUserReward/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!.put(uri, headers: headers).then((response) {
      print(response.toString());
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    });
  }

  Future<bool> deactivateUser(int id) {
    var url = "$_baseUrl" "Korisnici/deactivateUser/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    return http!.put(uri, headers: headers).then((response) {
      print(response.toString());
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    });
  }
}
