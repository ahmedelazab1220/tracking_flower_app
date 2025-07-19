import 'time_zone_entity.dart';

class CountryEntity {
  final String? isoCode;
  final String? name;
  final String? phoneCode;
  final String? flag;
  final String? currency;
  final String? latitude;
  final String? longitude;
  final List<TimezoneEntity>? timezones;

  CountryEntity({
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  });
}
