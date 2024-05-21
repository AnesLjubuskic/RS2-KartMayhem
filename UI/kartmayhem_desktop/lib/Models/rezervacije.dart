import 'package:json_annotation/json_annotation.dart';
import 'package:kartmayhem_desktop/Models/korisnik.dart';

part 'rezervacije.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Rezervacije {
  int? id;
  int? cijenaRezervacije;
  String? imeStaze;
  Korisnik? korisnik;

  Rezervacije({this.id, this.cijenaRezervacije, this.imeStaze, this.korisnik});

  factory Rezervacije.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijeToJson(this);
}
