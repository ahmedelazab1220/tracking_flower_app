import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../api/ai_model_service.dart';
import '../../api/apply_api_manager.dart';
import '../../api/auth_retrofit_client.dart';
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
import '../contract/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRetrofitClient _authRetrofitClient;
  final AiModelService _aiModelService;
  final ApplyApiManager _applyApiManager;

  AuthRemoteDataSourceImpl(
    this._authRetrofitClient,
    this._aiModelService,
    this._applyApiManager,
  );

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    return await _authRetrofitClient.login(request);
  }

  @override
  Future<ForgetPasswordResponseDto> forgetPassword(
    ForgetPasswordRequestDto forgetPasswordRequestDto,
  ) async {
    return await _authRetrofitClient.forgetPassword(forgetPasswordRequestDto);
  }

  @override
  Future<ResetPasswordResponseDto> resetPassword(
    ResetPasswordRequestDto resetPasswordRequestDto,
  ) async {
    return await _authRetrofitClient.resetPassword(resetPasswordRequestDto);
  }

  @override
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    VerifyResetCodeRequestDto verifyResetCodeRequestDto,
  ) async {
    return await _authRetrofitClient.verifyResetCode(verifyResetCodeRequestDto);
  }

  @override
  Future<VehiclesResponseDto> getVehicles() async {
    return await _authRetrofitClient.getVehicles();
  }

  @override
  Future<VehicleLicenseDto> extractDataFromDrivingLicense(
    File? imageFile,
  ) async {
    return await _aiModelService.extractDataFromVehicleLicense(imageFile);
  }

  @override
  Future<NationalIdDto> extractDataFromNationalId(File? imageFile) async {
    return await _aiModelService.extractDataFromNationalId(imageFile);
  }

  @override
  Future<ApplyResponseDto> apply(ApplyRequestDto applyRequestDto) async {
    return await _applyApiManager.apply(applyRequestDto);
  }
}
