import 'package:json_annotation/json_annotation.dart';

import '../../../domain/order/entity/orders_entity.dart';
import 'order_item_dto.dart';
import 'user_dto.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: "_id")
  final String? id;
  final UserDto? user;
  final List<OrderItemDto>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? orderNumber;
  final String? createdAt;
  final String? updatedAt;

  OrderDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.orderNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  OrderEntity toEntity() {
    return OrderEntity(
      id: id ?? '',
      orderNumber: orderNumber ?? '',
      totalPrice: totalPrice ?? 0,
      isDelivered: isDelivered ?? false,
      paymentType: paymentType ?? '',
      state: state ?? '',
      createdAt: createdAt ?? '',
      isPaid: isPaid ?? false,
      orderItems: orderItems?.map((e) => e.toEntity()).toList() ?? [],
      updatedAt: updatedAt ?? '',
      user: user?.toEntity(),
    );
  }
}
