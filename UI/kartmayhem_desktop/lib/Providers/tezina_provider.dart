import 'dart:io';
import 'package:http/io_client.dart';
import 'package:kartmayhem_desktop/Models/tezine.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class TezinaProvider extends BaseProvider<Tezine> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  TezinaProvider() : super("Tezine") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Tezine fromJson(data) {
    return Tezine.fromJson(data);
  }
}
