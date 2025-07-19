// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesResponseDto _$VehiclesResponseDtoFromJson(Map<String, dynamic> json) =>
    VehiclesResponseDto(
      message: json['message'] as String?,
      vehicles:
          (json['vehicles'] as List<dynamic>?)
              ?.map((e) => VehiclesDto.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$VehiclesResponseDtoToJson(
  VehiclesResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'vehicles': instance.vehicles,
};
