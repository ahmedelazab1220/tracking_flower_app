// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDto _$StoreDtoFromJson(Map<String, dynamic> json) => StoreDto(
  id: json['id'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
  address: json['address'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  latLong: json['latLong'] as String?,
);

Map<String, dynamic> _$StoreDtoToJson(StoreDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'address': instance.address,
  'phoneNumber': instance.phoneNumber,
  'latLong': instance.latLong,
};
