import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/time_zone_entity.dart';

part 'time_zone_dto.g.dart';

@JsonSerializable()
class TimezoneDto {
  @JsonKey(name: "zoneName")
  final String? zoneName;
  @JsonKey(name: "gmtOffset")
  final int? gmtOffset;
  @JsonKey(name: "gmtOffsetName")
  final String? gmtOffsetName;
  @JsonKey(name: "abbreviation")
  final String? abbreviation;
  @JsonKey(name: "tzName")
  final String? tzName;

  TimezoneDto({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory TimezoneDto.fromJson(Map<String, dynamic> json) =>
      _$TimezoneDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TimezoneDtoToJson(this);

  TimezoneEntity toEntity() => TimezoneEntity(
    zoneName: zoneName,
    gmtOffset: gmtOffset,
    gmtOffsetName: gmtOffsetName,
    abbreviation: abbreviation,
    tzName: tzName,
  );
}
