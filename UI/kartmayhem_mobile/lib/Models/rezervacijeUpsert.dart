import 'package:json_annotation/json_annotation.dart';

part 'rezervacijeUpsert.g.dart';

/// dart run build_runner build

@JsonSerializable()
class RezervacijeUpsert {
  int? cijenaPoOsobi;
  int? brojOsoba;
  String? dayOfReservation;
  String? timeSlot;
  int? korisnikId;
  int? stazaId;
  bool? isNagrada;
  bool? isGotovina;

  RezervacijeUpsert(
      {this.cijenaPoOsobi,
      this.brojOsoba,
      this.dayOfReservation,
      this.timeSlot,
      this.korisnikId,
      this.stazaId,
      this.isGotovina,
      this.isNagrada});

  factory RezervacijeUpsert.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeUpsertFromJson(json);
  Map<String, dynamic> toJson() => _$RezervacijeUpsertToJson(this);
}
