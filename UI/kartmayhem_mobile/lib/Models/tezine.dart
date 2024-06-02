import 'package:json_annotation/json_annotation.dart';

part 'tezine.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Tezine {
  String? naziv;
  int? id;

  Tezine({this.naziv, this.id});

  factory Tezine.fromJson(Map<String, dynamic> json) => _$TezineFromJson(json);
  Map<String, dynamic> toJson() => _$TezineToJson(this);
}
