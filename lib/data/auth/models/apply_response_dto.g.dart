// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyResponseDto _$ApplyResponseDtoFromJson(Map<String, dynamic> json) =>
    ApplyResponseDto(
      message: json['message'] as String?,
      token: json['token'] as String?,
      driver: DriverDto.fromJson(json['driver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApplyResponseDtoToJson(ApplyResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'driver': instance.driver,
    };
