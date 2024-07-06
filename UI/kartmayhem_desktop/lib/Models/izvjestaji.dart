import 'package:json_annotation/json_annotation.dart';

part 'izvjestaji.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Izvjestaji {
  int? brojRezervacijeStaze;
  int? ukupnaZaradaStaze;
  int? ukupanBrojKorisnikaAplikacije;
  int? ukupnaZaradaAplikacije;

  Izvjestaji(
      {this.brojRezervacijeStaze,
      this.ukupnaZaradaStaze,
      this.ukupanBrojKorisnikaAplikacije,
      this.ukupnaZaradaAplikacije});

  factory Izvjestaji.fromJson(Map<String, dynamic> json) =>
      _$IzvjestajiFromJson(json);
  Map<String, dynamic> toJson() => _$IzvjestajiToJson(this);
}
