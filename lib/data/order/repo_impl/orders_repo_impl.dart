import '../models/orders_dto.dart';

abstract class OrdersRepository {
  Future<OrdersDto> getOrders();
}
