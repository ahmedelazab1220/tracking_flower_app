class OrderItemEntity {
  final String id;
  final String product;
  final int price;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });
}
