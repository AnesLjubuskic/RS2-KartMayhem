import 'package:kartmayhem_desktop/Models/rezervacije.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  static String? _baseUrl;
  RezervacijeProvider() : super("Rezervacije") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Rezervacije fromJson(data) {
    return Rezervacije.fromJson(data);
  }
}
