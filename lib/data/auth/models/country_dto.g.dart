// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDto _$CountryDtoFromJson(Map<String, dynamic> json) => CountryDto(
  json['isoCode'] as String?,
  json['name'] as String?,
  json['phoneCode'] as String?,
  json['flag'] as String?,
  json['currency'] as String?,
  json['latitude'] as String?,
  json['longitude'] as String?,
  (json['timezones'] as List<dynamic>?)
      ?.map((e) => TimezoneDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CountryDtoToJson(CountryDto instance) =>
    <String, dynamic>{
      'isoCode': instance.isoCode,
      'name': instance.name,
      'phoneCode': instance.phoneCode,
      'flag': instance.flag,
      'currency': instance.currency,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'timezones': instance.timezones,
    };
