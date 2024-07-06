import 'package:kartmayhem_desktop/Models/gradovi.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class GradoviProvider extends BaseProvider<Gradovi> {
  static String? _baseUrl;
  GradoviProvider() : super("Gradovi") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Gradovi fromJson(data) {
    return Gradovi.fromJson(data);
  }
}
