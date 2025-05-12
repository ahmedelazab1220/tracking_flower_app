import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_manager.dart';
import 'package:tracking_flower_app/core/utils/datasource_excution/api_result.dart';
import 'package:tracking_flower_app/data/order_details/data_source/contract/order_details_remote_data_source.dart';
import '../../../domain/order_details/repo/order_details_repo.dart';

@Injectable(as: OrderDetailsRepo)
class OrderDetailsRepoImpl implements OrderDetailsRepo {
  final OrderDetailsRemoteDataSource _orderDetailsRemoteDataSource;
  final ApiManager _apiManager;

  OrderDetailsRepoImpl(this._orderDetailsRemoteDataSource, this._apiManager);

  @override
  Future<Result<void>> updateOrderState(String orderId, int status) async {
    return await _apiManager.execute(() async {
      await _orderDetailsRemoteDataSource.updateOrderState(orderId, status);
    });
  }
}
