import 'package:json_annotation/json_annotation.dart';

part 'gradovi.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Gradovi {
  String? nazivGrada;
  int? id;

  Gradovi({this.nazivGrada, this.id});

  factory Gradovi.fromJson(Map<String, dynamic> json) =>
      _$GradoviFromJson(json);
  Map<String, dynamic> toJson() => _$GradoviToJson(this);
}
