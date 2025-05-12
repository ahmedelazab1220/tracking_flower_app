import '../../../core/utils/datasource_excution/api_result.dart';

abstract class OrderDetailsRepo {
  Future<Result<void>> updateOrderState(String orderId, int status);
}
