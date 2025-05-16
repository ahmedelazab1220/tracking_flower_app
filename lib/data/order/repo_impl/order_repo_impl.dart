import '../models/order_dto.dart';

abstract class OrderRepository {
  Future<OrderDto> getOrder();
}
