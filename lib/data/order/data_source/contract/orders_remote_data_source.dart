import '../../models/order_dto.dart';

abstract class OrdersRemoteDataSource {
  Future<OrderDto> getOrders(String orderId);
}
