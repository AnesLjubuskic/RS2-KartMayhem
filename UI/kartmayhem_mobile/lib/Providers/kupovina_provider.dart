import 'dart:io';
import 'package:http/io_client.dart';
import 'package:kartmayhem_mobile/Models/kupovina.dart';

import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class KupovinaProvider extends BaseProvider<Kupovina> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  KupovinaProvider() : super("Kupovina") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Kupovina fromJson(data) {
    return Kupovina.fromJson(data);
  }
}
