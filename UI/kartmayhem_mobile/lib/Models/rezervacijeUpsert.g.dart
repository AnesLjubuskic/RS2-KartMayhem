// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijeUpsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijeUpsert _$RezervacijeUpsertFromJson(Map<String, dynamic> json) =>
    RezervacijeUpsert(
      cijenaPoOsobi: (json['cijenaPoOsobi'] as num?)?.toInt(),
      brojOsoba: (json['brojOsoba'] as num?)?.toInt(),
      dayOfReservation: json['dayOfReservation'] as String?,
      timeSlot: json['timeSlot'] as String?,
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      stazaId: (json['stazaId'] as num?)?.toInt(),
      isGotovina: json['isGotovina'] as bool?,
      isNagrada: json['isNagrada'] as bool?,
    );

Map<String, dynamic> _$RezervacijeUpsertToJson(RezervacijeUpsert instance) =>
    <String, dynamic>{
      'cijenaPoOsobi': instance.cijenaPoOsobi,
      'brojOsoba': instance.brojOsoba,
      'dayOfReservation': instance.dayOfReservation,
      'timeSlot': instance.timeSlot,
      'korisnikId': instance.korisnikId,
      'stazaId': instance.stazaId,
      'isNagrada': instance.isNagrada,
      'isGotovina': instance.isGotovina,
    };
