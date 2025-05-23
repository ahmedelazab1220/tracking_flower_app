import 'package:tracking_flower_app/domain/order/entity/user_entity.dart';

import 'order_item_entity.dart';

class OrderEntity {
  final String id;
  final String orderNumber;
  final bool isDelivered;
  final int totalPrice;
  final String paymentType;
  final String state;
  final UserEntity? user;
  final List<OrderItemEntity>? orderItems;
  final bool isPaid;
  final String? createdAt;
  final String? updatedAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.isDelivered,
    required this.totalPrice,
    required this.paymentType,
    required this.state,
    required this.createdAt,
    required this.isPaid,
    required this.orderItems,
    required this.updatedAt,
    required this.user,
  });
}
