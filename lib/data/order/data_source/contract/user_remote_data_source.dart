import '../../models/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<UserDto> getUser();
}
