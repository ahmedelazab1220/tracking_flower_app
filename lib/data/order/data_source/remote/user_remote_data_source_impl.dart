import 'package:injectable/injectable.dart';

import '../../api/orders_retrofit_client.dart';
import '../../models/user_dto.dart';
import '../contract/user_remote_data_source.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDatasourceImpl implements UserRemoteDataSource {
  final OrdersRetrofitClient _userRetrofitClient;

  UserRemoteDatasourceImpl(this._userRetrofitClient);

  @override
  Future<UserDto> getUser(String userId) async {
    return await _userRetrofitClient.getUser(userId);
  }
}
