// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacije _$RezervacijeFromJson(Map<String, dynamic> json) => Rezervacije(
      id: (json['id'] as num?)?.toInt(),
      cijenaRezervacije: (json['cijenaRezervacije'] as num?)?.toInt(),
      brojOsoba: (json['brojOsoba'] as num?)?.toInt(),
      staza: json['staza'] == null
          ? null
          : Staze.fromJson(json['staza'] as Map<String, dynamic>),
      timeSlot: json['timeSlot'] as String?,
      dayOfReservation: json['dayOfReservation'] as String?,
      imeStaze: json['imeStaze'] as String?,
    );

Map<String, dynamic> _$RezervacijeToJson(Rezervacije instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cijenaRezervacije': instance.cijenaRezervacije,
      'brojOsoba': instance.brojOsoba,
      'staza': instance.staza,
      'timeSlot': instance.timeSlot,
      'dayOfReservation': instance.dayOfReservation,
      'imeStaze': instance.imeStaze,
    };
