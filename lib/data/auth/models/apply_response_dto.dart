import 'package:json_annotation/json_annotation.dart';

import 'driver_dto.dart';

part 'apply_response_dto.g.dart';

@JsonSerializable()
class ApplyResponseDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'driver')
  final DriverDto driver;

  const ApplyResponseDto({
    required this.message,
    required this.token,
    required this.driver,
  });

  factory ApplyResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ApplyResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyResponseDtoToJson(this);
}
