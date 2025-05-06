import 'package:injectable/injectable.dart';
import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUsecase {
  final AuthRepo _authRep;

  LoginUsecase(this._authRep);

  Future<Result<void>> call(LoginRequestEntity request) async {
    return await _authRep.login(request);
  }
}
