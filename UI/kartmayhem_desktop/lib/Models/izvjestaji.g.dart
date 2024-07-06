// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Izvjestaji _$IzvjestajiFromJson(Map<String, dynamic> json) => Izvjestaji(
      brojRezervacijeStaze: (json['brojRezervacijeStaze'] as num?)?.toInt(),
      ukupnaZaradaStaze: (json['ukupnaZaradaStaze'] as num?)?.toInt(),
      ukupanBrojKorisnikaAplikacije:
          (json['ukupanBrojKorisnikaAplikacije'] as num?)?.toInt(),
      ukupnaZaradaAplikacije: (json['ukupnaZaradaAplikacije'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IzvjestajiToJson(Izvjestaji instance) =>
    <String, dynamic>{
      'brojRezervacijeStaze': instance.brojRezervacijeStaze,
      'ukupnaZaradaStaze': instance.ukupnaZaradaStaze,
      'ukupanBrojKorisnikaAplikacije': instance.ukupanBrojKorisnikaAplikacije,
      'ukupnaZaradaAplikacije': instance.ukupnaZaradaAplikacije,
    };
