import 'package:json_annotation/json_annotation.dart';

part 'driver_dto.g.dart';

@JsonSerializable()
class DriverDto {
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'vehicleType')
  final String? vehicleType;
  @JsonKey(name: 'vehicleNumber')
  final String? vehicleNumber;
  @JsonKey(name: 'vehicleLicense')
  final String? vehicleLicense;
  @JsonKey(name: 'NID')
  final String? nid;
  @JsonKey(name: 'NIDImg')
  final String? nidImg;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  const DriverDto({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
    this.email,
    this.gender,
    this.phone,
    this.role,
    this.photo,
    this.id,
    this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) =>
      _$DriverDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDtoToJson(this);
}
