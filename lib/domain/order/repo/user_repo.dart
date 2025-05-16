import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/user_entity.dart';

abstract class UserRepo {
  Future<Result<UserEntity>> getUser();
}
