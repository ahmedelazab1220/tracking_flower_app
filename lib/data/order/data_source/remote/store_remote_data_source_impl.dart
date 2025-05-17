import 'package:injectable/injectable.dart';

import '../../api/orders_retrofit_client.dart';
import '../../models/store_dto.dart';
import '../contract/store_remote_data_source.dart';

@Injectable(as: StoreRemoteDataSource)
class StoreRemoteDatasourceImpl implements StoreRemoteDataSource {
  final OrdersRetrofitClient _storeRetrofitClient;

  StoreRemoteDatasourceImpl(this._storeRetrofitClient);

  @override
  Future<StoreDto> getStore() async {
    return await _storeRetrofitClient.getStore(
      'storeId',
    );
  }
}
