import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/country_entity.dart';
import 'time_zone_dto.dart';

part 'country_dto.g.dart';

@JsonSerializable()
class CountryDto {
  @JsonKey(name: "isoCode")
  final String? isoCode;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "phoneCode")
  final String? phoneCode;
  @JsonKey(name: "flag")
  final String? flag;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "latitude")
  final String? latitude;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "timezones")
  final List<TimezoneDto>? timezones;

  CountryDto(
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  );

  factory CountryDto.fromJson(Map<String, dynamic> json) =>
      _$CountryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDtoToJson(this);

  CountryEntity toEntity() => CountryEntity(
    isoCode: isoCode,
    name: name,
    phoneCode: phoneCode,
    flag: flag,
    currency: currency,
    latitude: latitude,
    longitude: longitude,
    timezones: timezones?.map((e) => e.toEntity()).toList() ?? [],
  );
}
