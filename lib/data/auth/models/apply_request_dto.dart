import 'dart:io';

import '../../../domain/auth/entity/apply_request_entity.dart';

class ApplyRequestDto {
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

  ApplyRequestDto({
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

  factory ApplyRequestDto.fromDomain(ApplyRequestEntity request) =>
      ApplyRequestDto(
        country: request.country,
        firstName: request.firstName,
        lastName: request.lastName,
        vehicleType: request.vehicleType,
        vehicleNumber: request.vehicleNumber,
        vehicleLicense: request.vehicleLicense,
        nid: request.nid,
        nidImg: request.nidImg,
        email: request.email,
        password: request.password,
        rePassword: request.rePassword,
        gender: request.gender,
        phone: request.phone,
      );
}
