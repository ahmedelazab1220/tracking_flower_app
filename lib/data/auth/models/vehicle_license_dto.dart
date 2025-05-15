import 'package:json_annotation/json_annotation.dart';

import '../../../domain/auth/entity/vehicle_license_entity.dart';

part 'vehicle_license_dto.g.dart';

@JsonSerializable()
class VehicleLicenseDto {
  final String? driverName;
  final String? licenseNumber;
  final String? dateOfExpiry;
  final String? issuingAuthority;
  final bool isValidLicense;
  final String? vehicleCategories;
  final String? errorMessage;

  VehicleLicenseDto({
    this.driverName,
    this.licenseNumber,
    this.dateOfExpiry,
    this.issuingAuthority,
    this.isValidLicense = false,
    this.vehicleCategories,
    this.errorMessage,
  });

  factory VehicleLicenseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleLicenseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleLicenseDtoToJson(this);

  VehicleLicenseEntity toEntity() => VehicleLicenseEntity(
    driverName: driverName,
    licenseNumber: licenseNumber,
    dateOfExpiry: dateOfExpiry,
    issuingAuthority: issuingAuthority,
    isValidLicense: isValidLicense,
    vehicleCategories: vehicleCategories,
    errorMessage: errorMessage,
  );
}
