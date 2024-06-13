import 'package:kartmayhem_mobile/Models/rezervacijeUpsert.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class RezervacijeUpsertProvider extends BaseProvider<RezervacijeUpsert> {
  static String? _baseUrl;
  RezervacijeUpsertProvider() : super("Rezervacije") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  RezervacijeUpsert fromJson(data) {
    return RezervacijeUpsert.fromJson(data);
  }
}
