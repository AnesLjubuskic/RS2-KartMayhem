import 'dart:io';
import 'package:http/io_client.dart';
import 'package:kartmayhem_desktop/Models/feedback.dart';
import 'package:kartmayhem_desktop/Providers/base_provided.dart';

class FeedbackProvider extends BaseProvider<Feedback> {
  HttpClient client = HttpClient();
  IOClient? http;
  static String? _baseUrl;
  FeedbackProvider() : super("Feedback") {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:8080/");
    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }
  }
  @override
  Feedback fromJson(data) {
    return Feedback.fromJson(data);
  }
}
