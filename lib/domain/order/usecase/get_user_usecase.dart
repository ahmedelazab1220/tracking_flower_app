import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../entity/user_entity.dart';
import '../repo/user_repo.dart';

@injectable
class GetUserUsecase {
  final UserRepo _userRepo;

  GetUserUsecase(this._userRepo);

  Future<Result<UserEntity>> call() async {
    return await _userRepo.getUser();
  }
}
