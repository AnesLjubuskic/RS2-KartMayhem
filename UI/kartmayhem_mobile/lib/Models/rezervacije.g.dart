// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacije _$RezervacijeFromJson(Map<String, dynamic> json) => Rezervacije(
      id: (json['id'] as num?)?.toInt(),
      cijenaRezervacije: (json['cijenaRezervacije'] as num?)?.toInt(),
      imeStaze: json['imeStaze'] as String?,
    );

Map<String, dynamic> _$RezervacijeToJson(Rezervacije instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cijenaRezervacije': instance.cijenaRezervacije,
      'imeStaze': instance.imeStaze,
    };
