import 'package:json_annotation/json_annotation.dart';

import 'vehicles_dto.dart';

part 'vehicles_response_dto.g.dart';

@JsonSerializable()
class VehiclesResponseDto {
  final String? message;
  final List<VehiclesDto>? vehicles;

  VehiclesResponseDto({this.message, this.vehicles});

  factory VehiclesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehiclesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesResponseDtoToJson(this);
}
