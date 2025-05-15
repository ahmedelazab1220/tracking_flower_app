// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_zone_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimezoneDto _$TimezoneDtoFromJson(Map<String, dynamic> json) => TimezoneDto(
  zoneName: json['zoneName'] as String?,
  gmtOffset: (json['gmtOffset'] as num?)?.toInt(),
  gmtOffsetName: json['gmtOffsetName'] as String?,
  abbreviation: json['abbreviation'] as String?,
  tzName: json['tzName'] as String?,
);

Map<String, dynamic> _$TimezoneDtoToJson(TimezoneDto instance) =>
    <String, dynamic>{
      'zoneName': instance.zoneName,
      'gmtOffset': instance.gmtOffset,
      'gmtOffsetName': instance.gmtOffsetName,
      'abbreviation': instance.abbreviation,
      'tzName': instance.tzName,
    };
