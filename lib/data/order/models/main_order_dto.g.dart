// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainOrderDto _$MainOrderDtoFromJson(Map<String, dynamic> json) => MainOrderDto(
      id: json['_id'] as String?,
      driverId: json['driver'] as String?,
      order: json['order'] == null
          ? null
          : OrderDto.fromJson(json['order'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : StoreDto.fromJson(json['store'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MainOrderDtoToJson(MainOrderDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'driver': instance.driverId,
      'order': instance.order,
      'store': instance.store,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
