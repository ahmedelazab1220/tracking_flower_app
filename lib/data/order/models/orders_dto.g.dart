// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersDto _$OrdersDtoFromJson(Map<String, dynamic> json) => OrdersDto(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => MainOrderDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersDtoToJson(OrdersDto instance) => <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'orders': instance.orders,
    };
