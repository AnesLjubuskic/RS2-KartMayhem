import 'package:json_annotation/json_annotation.dart';
import 'package:kartmayhem_desktop/Models/gradovi.dart';
import 'package:kartmayhem_desktop/Models/tezine.dart';

part 'staze.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Staze {
  int? id;
  String? nazivStaze;
  String? opisStaze;
  int? cijenaPoOsobi;
  double? duzinaStaze;
  int? brojKrugova;
  int? maxBrojOsoba;
  int? brojRezervacija;
  String? slika;
  Tezine? tezina;
  Gradovi? gradovi;

  Staze(
      {this.id,
      this.nazivStaze,
      this.opisStaze,
      this.cijenaPoOsobi,
      this.duzinaStaze,
      this.brojKrugova,
      this.maxBrojOsoba,
      this.brojRezervacija,
      this.slika,
      this.tezina,
      this.gradovi});

  factory Staze.fromJson(Map<String, dynamic> json) => _$StazeFromJson(json);
  Map<String, dynamic> toJson() => _$StazeToJson(this);
}
