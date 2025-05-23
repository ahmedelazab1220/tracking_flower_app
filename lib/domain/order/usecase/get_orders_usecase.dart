import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../entity/orders_entity.dart';
import '../repo/orders_repo.dart';

@injectable
class GetOrdersUsecase {
  final OrdersRepo _ordersRepo;

  GetOrdersUsecase(this._ordersRepo);

  Future<Result<OrderEntity>> call(String ordersId) async {
    return await _ordersRepo.getOrders(ordersId);
  }
}
