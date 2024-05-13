import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Korisnik {
  int? id;
  String? ime;
  String? prezime;
  String? email;
  String? lozinka;
  bool? isNagrada;
  int? brojRezervacija;
  String? punoIme;

  Korisnik(
      {this.id,
      this.ime,
      this.prezime,
      this.email,
      this.lozinka,
      this.isNagrada,
      this.brojRezervacija,
      this.punoIme});

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);
  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
