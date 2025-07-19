class VehicleLicenseEntity {
  final String? driverName;
  final String? licenseNumber;
  final String? dateOfExpiry;
  final String? issuingAuthority;
  final bool isValidLicense;
  final String? vehicleCategories;
  final String? errorMessage;

  VehicleLicenseEntity({
    required this.driverName,
    required this.licenseNumber,
    required this.dateOfExpiry,
    required this.issuingAuthority,
    required this.isValidLicense,
    required this.vehicleCategories,
    required this.errorMessage,
  });
}
