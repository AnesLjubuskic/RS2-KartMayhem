import 'dart:convert';

import 'package:kartmayhem_mobile/Models/rezervacije.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  static String? _baseUrl;
  RezervacijeProvider() : super("Staze") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Rezervacije fromJson(data) {
    return Rezervacije.fromJson(data);
  }

  Future<List<String>> getReservationTimeSlots(
      int stazaId, String datumRezervacije) async {
    var url = "$_baseUrl"
        "Rezervacije/timeSlots?stazaId=$stazaId&datumRezervacije=$datumRezervacije";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    try {
      final response = await http!.get(uri, headers: headers);

      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body) as List<dynamic>;
        return data.map((item) => item.toString()).toList();
      } else {
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body);
          throw Exception(
              "${data["errors"]["reservationError"][0].toString()}");
        }
        throw Exception('Something went wrong!');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
