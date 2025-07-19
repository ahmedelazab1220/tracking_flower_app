import 'dart:io';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/forget_password_request_dto.dart';
import '../../../data/auth/models/reset_password_request_dto.dart';
import '../../../data/auth/models/verify_reset_code_request_dto.dart';
import '../entity/apply_request_entity.dart';
import '../entity/country_entity.dart';
import '../entity/login_request_entity.dart';
import '../entity/national_id_entity.dart';
import '../entity/vehicle_license_entity.dart';
import '../entity/vehicles_entity.dart';

abstract class AuthRepo {
  Future<Result<void>> login(LoginRequestEntity request);

  Future<Result<void>> forgetPassword(ForgetPasswordRequestDto request);

  Future<Result<void>> verifyResetCode(VerifyResetCodeRequestDto request);

  Future<Result<void>> resetPassword(ResetPasswordRequestDto request);

  Future<List<CountryEntity>> getCountries();

  Future<Result<List<VehiclesEntity>>> getVehicles();

  Future<Result<VehicleLicenseEntity>> extractDataFromVehicleLicense(
    File? vehicleLicenseImage,
  );

  Future<Result<NationalIdEntity>> extractDataFromNationalId(
    File? nationalIdImage,
  );

  Future<Result<void>> apply(ApplyRequestEntity request);
}
