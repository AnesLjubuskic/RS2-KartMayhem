import 'package:json_annotation/json_annotation.dart';
import 'package:kartmayhem_mobile/Models/korisnik.dart';
import 'package:kartmayhem_mobile/Models/staze.dart';

part 'kupovina.g.dart';

@JsonSerializable()
class Kupovina {
  int? id;
  int? kolicina;
  int? cijena;
  DateTime datumKupovine;
  String? paymentIntentId;
  int? korisnikId;
  Korisnik? korisnik;
  int? stazeId;
  Staze? staze;
  bool? placena;

  Kupovina(
      {required this.id,
      this.kolicina,
      this.cijena,
      required this.datumKupovine,
      this.paymentIntentId,
      this.korisnikId,
      this.korisnik,
      this.stazeId,
      this.staze,
      this.placena});

  factory Kupovina.fromJson(Map<String, dynamic> json) =>
      _$KupovinaFromJson(json);
  Map<String, dynamic> toJson() => _$KupovinaToJson(this);
}
