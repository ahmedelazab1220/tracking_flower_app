import 'package:json_annotation/json_annotation.dart';

import 'order_dto.dart';
import 'store_dto.dart';

part 'main_order_dto.g.dart';

@JsonSerializable()
class MainOrderDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "driver")
  final String? driverId;
  final OrderDto? order;
  final StoreDto? store;
  final String? createdAt;
  final String? updatedAt;

  MainOrderDto({
    this.id,
    this.driverId,
    this.order,
    this.store,
    this.createdAt,
    this.updatedAt,
  });

  factory MainOrderDto.fromJson(Map<String, dynamic> json) =>
      _$MainOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MainOrderDtoToJson(this);
}
