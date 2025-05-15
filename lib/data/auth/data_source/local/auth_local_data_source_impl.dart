import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constants.dart';
import '../../models/country_dto.dart';
import '../contract/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage _flutterSecureStorage;
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl(this._flutterSecureStorage, this._sharedPreferences);

  @override
  Future<void> deleteToken(String key) async {
    return await _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String?> getToken(String key) async {
    return await _flutterSecureStorage.read(key: key) ?? '';
  }

  @override
  Future<void> saveToken(String key, String value) async {
    await _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> setRememberMe(bool value) async {
    _sharedPreferences.setBool(Constants.isRememberMe, value);
  }

  @override
  Future<bool> isRememberMe() async {
    return _sharedPreferences.getBool(Constants.isRememberMe) ?? false;
  }

  @override
  Future<void> clearAll() async {
    return await _flutterSecureStorage.deleteAll();
  }

  @override
  Future<List<CountryDto>> getAllCountries() async {
    return await Future.delayed(const Duration(seconds: 1), () async {
      final countries = await rootBundle.loadString(Constants.assetsCountries);
      final countriesJson = json.decode(countries) as List;
      return countriesJson.map((e) => CountryDto.fromJson(e)).toList();
    });
  }
}
