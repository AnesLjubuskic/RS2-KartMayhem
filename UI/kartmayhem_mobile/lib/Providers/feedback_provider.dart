import 'dart:io';
import 'package:http/io_client.dart';
import 'package:kartmayhem_mobile/Models/rezencije.dart';

import 'package:kartmayhem_mobile/Providers/base_provided.dart';

class FeedbackProvider extends BaseProvider<Rezencije> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  FeedbackProvider() : super("Feedback") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://10.0.2.2:5258/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Rezencije fromJson(data) {
    return Rezencije.fromJson(data);
  }
}
