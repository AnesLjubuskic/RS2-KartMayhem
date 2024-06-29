import 'package:json_annotation/json_annotation.dart';

part 'rezencije.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Rezencije {
  int? id;
  int? ocjena;
  int? stazaId;

  Rezencije({this.id, this.ocjena, this.stazaId});

  factory Rezencije.fromJson(Map<String, dynamic> json) =>
      _$RezencijeFromJson(json);
  Map<String, dynamic> toJson() => _$RezencijeToJson(this);
}
