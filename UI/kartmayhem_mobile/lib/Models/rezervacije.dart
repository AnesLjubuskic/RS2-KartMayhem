import 'package:json_annotation/json_annotation.dart';

part 'rezervacije.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Rezervacije {
  int? id;
  int? cijenaRezervacije;
  String? imeStaze;

  Rezervacije({this.id, this.cijenaRezervacije, this.imeStaze});

  factory Rezervacije.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijeToJson(this);
}
