// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehiclesDto _$VehiclesDtoFromJson(Map<String, dynamic> json) => VehiclesDto(
  id: json['_id'] as String?,
  type: json['type'] as String?,
  image: json['image'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$VehiclesDtoToJson(VehiclesDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
