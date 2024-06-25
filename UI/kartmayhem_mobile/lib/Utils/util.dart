import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Authorization {
  static String? email;
  static String? password;
  static int? id;
  static bool isNagrada = false;
  static bool? popupShown;
}

Image imageFromBase64String(
  String base64Image, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return Image.memory(
    base64Decode(base64Image),
    fit: fit,
    width: width?.toDouble(),
    height: height?.toDouble(),
    alignment: Alignment.topCenter,
  );
}

String imageToBase64(Uint8List imageBytes) {
  return base64Encode(imageBytes);
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
