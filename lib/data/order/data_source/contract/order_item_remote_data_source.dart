import '../../models/order_item_dto.dart';

abstract class OrderItemRemoteDataSource {
  Future<OrderItemDto> getOrderItem(String productId);
}
