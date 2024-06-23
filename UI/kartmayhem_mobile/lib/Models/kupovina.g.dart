// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kupovina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kupovina _$KupovinaFromJson(Map<String, dynamic> json) => Kupovina(
      id: (json['id'] as num?)?.toInt(),
      kolicina: (json['kolicina'] as num?)?.toInt(),
      cijena: (json['cijena'] as num?)?.toInt(),
      datumKupovine: DateTime.parse(json['datumKupovine'] as String),
      paymentIntentId: json['paymentIntentId'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      korisnik: json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
      stazeId: (json['stazeId'] as num?)?.toInt(),
      staze: json['staze'] == null
          ? null
          : Staze.fromJson(json['staze'] as Map<String, dynamic>),
      placena: json['placena'] as bool?,
    );

Map<String, dynamic> _$KupovinaToJson(Kupovina instance) => <String, dynamic>{
      'id': instance.id,
      'kolicina': instance.kolicina,
      'cijena': instance.cijena,
      'datumKupovine': instance.datumKupovine.toIso8601String(),
      'paymentIntentId': instance.paymentIntentId,
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
      'stazeId': instance.stazeId,
      'staze': instance.staze,
      'placena': instance.placena,
    };
