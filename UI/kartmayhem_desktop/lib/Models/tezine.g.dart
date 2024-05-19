// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tezine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tezine _$TezineFromJson(Map<String, dynamic> json) => Tezine(
      naziv: json['naziv'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TezineToJson(Tezine instance) => <String, dynamic>{
      'naziv': instance.naziv,
      'id': instance.id,
    };
