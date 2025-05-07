import 'package:tracking_flower_app/domain/auth/entity/login_request_entity.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/forget_password_request_dto.dart';
import '../../../data/auth/models/reset_password_request_dto.dart';
import '../../../data/auth/models/verify_reset_code_request_dto.dart';

abstract class AuthRepo {
  Future<Result<void>> login(LoginRequestEntity request);

  Future<Result<void>> forgetPassword(ForgetPasswordRequestDto request);

  Future<Result<void>> verifyResetCode(VerifyResetCodeRequestDto request);

  Future<Result<void>> resetPassword(ResetPasswordRequestDto request);
}
