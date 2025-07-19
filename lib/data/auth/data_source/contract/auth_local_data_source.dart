import '../../models/country_dto.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String key, String value);

  Future<String?> getToken(String key);

  Future<void> deleteToken(String key);

  Future<void> setRememberMe(bool value);

  Future<bool> isRememberMe();

  Future<void> clearAll();

  Future<List<CountryDto>> getAllCountries();
}
