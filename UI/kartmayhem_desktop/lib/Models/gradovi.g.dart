// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradovi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gradovi _$GradoviFromJson(Map<String, dynamic> json) => Gradovi(
      nazivGrada: json['nazivGrada'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GradoviToJson(Gradovi instance) => <String, dynamic>{
      'nazivGrada': instance.nazivGrada,
      'id': instance.id,
    };
