import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/auth/entity/apply_request_entity.dart';
import '../../../domain/auth/entity/country_entity.dart';
import '../../../domain/auth/entity/login_request_entity.dart';
import '../../../domain/auth/entity/national_id_entity.dart';
import '../../../domain/auth/entity/vehicle_license_entity.dart';
import '../../../domain/auth/entity/vehicles_entity.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../data_source/contract/auth_local_data_source.dart';
import '../data_source/contract/auth_remote_data_source.dart';
import '../models/apply_request_dto.dart';
import '../models/login_request_dto.dart';
import '../models/login_response_dto.dart';
import '../models/forget_password_request_dto.dart';
import '../models/reset_password_request_dto.dart';
import '../models/verify_reset_code_request_dto.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiManager _apiManager;
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._apiManager,
  );

  @override
  Future<Result<void>> login(LoginRequestEntity request) {
    var response = _apiManager.execute<LoginResponseDto>(() async {
      final response = await _authRemoteDataSource.login(
        LoginRequestDto.fromDomain(request),
      );
      _authLocalDataSource.saveToken(Constants.token, response.token ?? "");
      _authLocalDataSource.setRememberMe(request.isRememberMe);
      return response;
    });
    return response;
  }

  @override
  Future<Result<void>> forgetPassword(
    ForgetPasswordRequestDto forgetPasswordRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.forgetPassword(forgetPasswordRequestDto);
    });
  }

  @override
  Future<Result<void>> resetPassword(
    ResetPasswordRequestDto resetPasswordRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.resetPassword(resetPasswordRequestDto);
    });
  }

  @override
  Future<Result<void>> verifyResetCode(
    VerifyResetCodeRequestDto verifyResetCodeRequestDto,
  ) async {
    return await _apiManager.execute(() async {
      await _authRemoteDataSource.verifyResetCode(verifyResetCodeRequestDto);
    });
  }

  @override
  Future<List<CountryEntity>> getCountries() async {
    final response = await _authLocalDataSource.getAllCountries();
    return response.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Result<List<VehiclesEntity>>> getVehicles() {
    var response = _apiManager.execute<List<VehiclesEntity>>(() async {
      var response = await _authRemoteDataSource.getVehicles();
      return response.vehicles!.map((e) => e.toEntity()).toList();
    });
    return response;
  }

  @override
  Future<Result<VehicleLicenseEntity>> extractDataFromVehicleLicense(
    File? vehicleLicenseImage,
  ) async {
    var response = await _authRemoteDataSource.extractDataFromDrivingLicense(
      vehicleLicenseImage,
    );
    if (!response.isValidLicense) {
      return FailureResult(
        Exception(response.errorMessage ?? 'Invalid driving license'),
      );
    }
    return SuccessResult(response.toEntity());
  }

  @override
  Future<Result<NationalIdEntity>> extractDataFromNationalId(
    File? nationalIdImage,
  ) async {
    var response = await _authRemoteDataSource.extractDataFromNationalId(
      nationalIdImage,
    );
    if (!response.isValidNationalId) {
      return FailureResult(
        Exception(response.errorMessage ?? 'Invalid National Id license'),
      );
    }
    return SuccessResult(response.toEntity());
  }

  @override
  Future<Result<void>> apply(ApplyRequestEntity request) {
    var response = _apiManager.execute(() async {
      var response = await _authRemoteDataSource.apply(
        ApplyRequestDto.fromDomain(request),
      );
      return response;
    });
    return response;
  }
}
