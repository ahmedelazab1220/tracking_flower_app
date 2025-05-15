// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_license_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleLicenseDto _$VehicleLicenseDtoFromJson(Map<String, dynamic> json) =>
    VehicleLicenseDto(
      driverName: json['driverName'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      dateOfExpiry: json['dateOfExpiry'] as String?,
      issuingAuthority: json['issuingAuthority'] as String?,
      isValidLicense: json['isValidLicense'] as bool? ?? false,
      vehicleCategories: json['vehicleCategories'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$VehicleLicenseDtoToJson(VehicleLicenseDto instance) =>
    <String, dynamic>{
      'driverName': instance.driverName,
      'licenseNumber': instance.licenseNumber,
      'dateOfExpiry': instance.dateOfExpiry,
      'issuingAuthority': instance.issuingAuthority,
      'isValidLicense': instance.isValidLicense,
      'vehicleCategories': instance.vehicleCategories,
      'errorMessage': instance.errorMessage,
    };
