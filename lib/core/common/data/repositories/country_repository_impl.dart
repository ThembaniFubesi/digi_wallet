import 'package:digi_wallet/config/app_config.dart';
import 'package:digi_wallet/core/common/data/datasources/remote_datasource.dart';
import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';
import 'package:digi_wallet/core/common/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final RemoteDatasource datasource;

  CountryRepositoryImpl({required this.datasource});

  @override
  Future<List<CountryEntity>> all() async {
    final response = await datasource.getCountries();
    return response.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<CountryEntity>> banned() async {
    final countries = await all();
    return AppConfig.bannedCountryIsoCodes
        .map(
          (isoCode) => countries.firstWhere(
            (country) => country.code == isoCode,
          ),
        )
        .toList();
  }
}
