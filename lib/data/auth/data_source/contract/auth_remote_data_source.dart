import '../../models/login_request_dto.dart';
import '../../models/login_response_dto.dart';
import '../../models/forget_password_request_dto.dart';
import '../../models/forget_password_response_dto.dart';
import '../../models/reset_password_request_dto.dart';
import '../../models/reset_password_response_dto.dart';
import '../../models/verify_reset_code_request_dto.dart';
import '../../models/verify_reset_code_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseDto> login(LoginRequestDto request);

  Future<ForgetPasswordResponseDto> forgetPassword(
      ForgetPasswordRequestDto request,
      );

  Future<ResetPasswordResponseDto> resetPassword(
      ResetPasswordRequestDto request,
      );

  Future<VerifyResetCodeResponseDto> verifyResetCode(
      VerifyResetCodeRequestDto request,
      );
}
