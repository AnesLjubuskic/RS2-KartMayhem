// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staze.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staze _$StazeFromJson(Map<String, dynamic> json) => Staze(
      id: (json['id'] as num?)?.toInt(),
      nazivStaze: json['nazivStaze'] as String?,
      opisStaze: json['opisStaze'] as String?,
      cijenaPoOsobi: (json['cijenaPoOsobi'] as num?)?.toInt(),
      duzinaStaze: (json['duzinaStaze'] as num?)?.toDouble(),
      brojKrugova: (json['brojKrugova'] as num?)?.toInt(),
      maxBrojOsoba: (json['maxBrojOsoba'] as num?)?.toInt(),
      brojRezervacija: (json['brojRezervacija'] as num?)?.toInt(),
      slika: json['slika'] as String?,
      tezina: json['tezina'] == null
          ? null
          : Tezine.fromJson(json['tezina'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StazeToJson(Staze instance) => <String, dynamic>{
      'id': instance.id,
      'nazivStaze': instance.nazivStaze,
      'opisStaze': instance.opisStaze,
      'cijenaPoOsobi': instance.cijenaPoOsobi,
      'duzinaStaze': instance.duzinaStaze,
      'brojKrugova': instance.brojKrugova,
      'maxBrojOsoba': instance.maxBrojOsoba,
      'brojRezervacija': instance.brojRezervacija,
      'slika': instance.slika,
      'tezina': instance.tezina,
    };
