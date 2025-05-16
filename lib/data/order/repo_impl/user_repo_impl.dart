import '../models/user_dto.dart';

abstract class UserRepository {
  Future<UserDto> getUser();
}
