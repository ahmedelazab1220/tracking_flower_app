class OrdersEntity {
  final String id;
  final String orderNumber;
  final bool isDelivered;
  final int totalPrice;
  final String paymentType;
  final String state;

  const OrdersEntity({
    required this.id,
    required this.orderNumber,
    required this.isDelivered,
    required this.totalPrice,
    required this.paymentType,
    required this.state,
  });
}
