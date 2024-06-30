// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      komentar: json['komentar'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'komentar': instance.komentar,
      'korisnikId': instance.korisnikId,
    };
