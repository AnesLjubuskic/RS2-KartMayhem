// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUser _$TopUserFromJson(Map<String, dynamic> json) => TopUser(
      id: (json['id'] as num?)?.toInt(),
      punoIme: json['punoIme'] as String?,
      brojRezervacija: (json['brojRezervacija'] as num?)?.toInt(),
      isNagrada: json['isNagrada'] as bool?,
    );

Map<String, dynamic> _$TopUserToJson(TopUser instance) => <String, dynamic>{
      'id': instance.id,
      'punoIme': instance.punoIme,
      'brojRezervacija': instance.brojRezervacija,
      'isNagrada': instance.isNagrada,
    };
