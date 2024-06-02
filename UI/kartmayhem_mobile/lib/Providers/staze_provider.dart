import 'package:kartmayhem_mobile/Models/staze.dart';
import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class StazeProvider extends BaseProvider<Staze> {
  static String? _baseUrl;
  StazeProvider() : super("Staze") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:44338/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Staze fromJson(data) {
    return Staze.fromJson(data);
  }
}
