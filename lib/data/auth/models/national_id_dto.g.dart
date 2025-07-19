// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'national_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationalIdDto _$NationalIdDtoFromJson(Map<String, dynamic> json) =>
    NationalIdDto(
      idNumber: json['idNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      name: json['name'] as String?,
      isValidNationalId: json['isValidNationalId'] as bool,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$NationalIdDtoToJson(NationalIdDto instance) =>
    <String, dynamic>{
      'idNumber': instance.idNumber,
      'dateOfBirth': instance.dateOfBirth,
      'name': instance.name,
      'isValidNationalId': instance.isValidNationalId,
      'errorMessage': instance.errorMessage,
    };
