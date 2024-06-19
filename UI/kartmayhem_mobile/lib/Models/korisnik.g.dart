// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      id: (json['id'] as num?)?.toInt(),
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      email: json['email'] as String?,
      lozinka: json['lozinka'] as String?,
      isNagrada: json['isNagrada'] as bool?,
      brojRezervacija: (json['brojRezervacija'] as num?)?.toInt(),
      punoIme: json['punoIme'] as String?,
      slika: json['slika'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'lozinka': instance.lozinka,
      'isNagrada': instance.isNagrada,
      'brojRezervacija': instance.brojRezervacija,
      'punoIme': instance.punoIme,
      'slika': instance.slika,
    };
