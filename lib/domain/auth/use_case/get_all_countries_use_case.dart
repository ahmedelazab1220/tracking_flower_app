import 'package:injectable/injectable.dart';

import '../entity/country_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class GetAllCountriesUseCase {
  final AuthRepo _authRepo;

  GetAllCountriesUseCase(this._authRepo);

  Future<List<CountryEntity>> call() async => await _authRepo.getCountries();
}
