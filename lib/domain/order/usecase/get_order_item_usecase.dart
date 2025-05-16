import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../entity/order_item_entity.dart';
import '../repo/order_item_repo.dart';

@injectable
class GetOrderItemUsecase {
  final OrderItemRepo _orderItemRepo;

  GetOrderItemUsecase(this._orderItemRepo);

  Future<Result<OrderItemEntity>> call() async {
    return await _orderItemRepo.getOrderItem();
  }
}
