import 'package:json_annotation/json_annotation.dart';

part 'topuser.g.dart';

@JsonSerializable()
class TopUser {
  int? id;
  String? punoIme;
  int? brojRezervacija;
  bool? isNagrada;

  TopUser({this.id, this.punoIme, this.brojRezervacija, this.isNagrada});

  /// Connect the generated [_$TopuserFromJson] function to the `fromJson`
  /// factory.
  /// dart run build_runner build
  factory TopUser.fromJson(Map<String, dynamic> json) =>
      _$TopUserFromJson(json);

  /// Connect the generated [_$TopuserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TopUserToJson(this);
}
