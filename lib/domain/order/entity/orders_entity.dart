class OrdersEntity {
  final String? orderNumber;
  final bool? isDelivered;
  final int? totalPrice;
  final String? paymentType;
  final String? state;

  const OrdersEntity({
    this.orderNumber,
    this.isDelivered,
    this.totalPrice,
    this.paymentType,
    this.state,
  });
}
