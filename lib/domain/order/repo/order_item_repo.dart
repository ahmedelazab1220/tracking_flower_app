import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/order_item_entity.dart';

abstract class OrderItemRepo {
  Future<Result<OrderItemEntity>> getOrderItem();
}
