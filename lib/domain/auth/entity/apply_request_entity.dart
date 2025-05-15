import 'dart:io';

class ApplyRequestEntity {
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final File vehicleLicense;
  final String nid;
  final File nidImg;
  final String email;
  final String password;
  final String rePassword;
  final String gender;
  final String phone;

  const ApplyRequestEntity({
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.gender,
    required this.phone,
  });
}
