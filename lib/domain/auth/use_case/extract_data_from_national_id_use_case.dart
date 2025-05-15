import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/national_id_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class ExtractDataFromNationalIdUseCase {
  final AuthRepo _authRepo;

  ExtractDataFromNationalIdUseCase(this._authRepo);

  Future<Result<NationalIdEntity>> call(File? nationalIdImage) async =>
      await _authRepo.extractDataFromNationalId(nationalIdImage);
}
