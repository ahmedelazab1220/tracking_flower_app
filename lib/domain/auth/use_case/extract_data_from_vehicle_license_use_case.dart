import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/vehicle_license_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ExtractDataFromVehicleLicenseUseCase {
  final AuthRepo _authRepo;

  ExtractDataFromVehicleLicenseUseCase(this._authRepo);

  Future<Result<VehicleLicenseEntity>> call(File? vehicleLicenseImage) async {
    return await _authRepo.extractDataFromVehicleLicense(vehicleLicenseImage);
  }
}
