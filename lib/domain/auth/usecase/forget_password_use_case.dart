import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/forget_password_request_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<Result<void>> call(ForgetPasswordRequestDto request) async {
    return await _authRepo.forgetPassword(request);
  }
}
