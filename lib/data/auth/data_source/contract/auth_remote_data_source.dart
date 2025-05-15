import 'dart:io';

import '../../models/apply_request_dto.dart';
import '../../models/apply_response_dto.dart';
import '../../models/login_request_dto.dart';
import '../../models/login_response_dto.dart';
import '../../models/forget_password_request_dto.dart';
import '../../models/forget_password_response_dto.dart';
import '../../models/national_id_dto.dart';
import '../../models/reset_password_request_dto.dart';
import '../../models/reset_password_response_dto.dart';
import '../../models/vehicle_license_dto.dart';
import '../../models/vehicles_response_dto.dart';
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

  Future<VehiclesResponseDto> getVehicles();

  Future<VehicleLicenseDto> extractDataFromDrivingLicense(File? imageFile);

  Future<NationalIdDto> extractDataFromNationalId(File? imageFile);

  Future<ApplyResponseDto> apply(ApplyRequestDto applyRequestDto);
}
