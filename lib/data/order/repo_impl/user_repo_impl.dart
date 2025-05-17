import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/order/entity/user_entity.dart';
import '../../../domain/order/repo/user_repo.dart';
import '../data_source/contract/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepo {
  final ApiManager _apiManager;
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._apiManager);

  @override
  Future<Result<UserEntity>> getUser() async {
    return await _apiManager.execute(() async {
      final response = await _userRemoteDataSource.getUser();
      return response.toEntity();
    });
  }
}
