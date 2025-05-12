import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/domain/order_details/repo/order_details_repo.dart';

import '../../../core/utils/datasource_excution/api_result.dart';

@injectable
class UpdateOrderStateUseCase {
  final OrderDetailsRepo _orderDetailsRepo;

  UpdateOrderStateUseCase(this._orderDetailsRepo);

  Future<Result<void>> call(String orderId, int status) async {
    return await _orderDetailsRepo.updateOrderState(orderId, status);
  }
}
