// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezencije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezencije _$RezencijeFromJson(Map<String, dynamic> json) => Rezencije(
      id: (json['id'] as num?)?.toInt(),
      ocjena: (json['ocjena'] as num?)?.toInt(),
      stazaId: (json['stazaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RezencijeToJson(Rezencije instance) => <String, dynamic>{
      'id': instance.id,
      'ocjena': instance.ocjena,
      'stazaId': instance.stazaId,
    };
