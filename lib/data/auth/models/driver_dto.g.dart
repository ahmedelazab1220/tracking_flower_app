// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDto _$DriverDtoFromJson(Map<String, dynamic> json) => DriverDto(
  country: json['country'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  vehicleType: json['vehicleType'] as String?,
  vehicleNumber: json['vehicleNumber'] as String?,
  vehicleLicense: json['vehicleLicense'] as String?,
  nid: json['NID'] as String?,
  nidImg: json['NIDImg'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  role: json['role'] as String?,
  photo: json['photo'] as String?,
  id: json['_id'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$DriverDtoToJson(DriverDto instance) => <String, dynamic>{
  'country': instance.country,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'vehicleType': instance.vehicleType,
  'vehicleNumber': instance.vehicleNumber,
  'vehicleLicense': instance.vehicleLicense,
  'NID': instance.nid,
  'NIDImg': instance.nidImg,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
  'role': instance.role,
  'photo': instance.photo,
  '_id': instance.id,
  'createdAt': instance.createdAt,
};
