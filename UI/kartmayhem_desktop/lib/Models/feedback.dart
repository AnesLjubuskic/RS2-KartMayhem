import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

/// dart run build_runner build

@JsonSerializable()
class Feedback {
  String? komentar;
  int? korisnikId;

  Feedback({this.komentar, this.korisnikId});

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
