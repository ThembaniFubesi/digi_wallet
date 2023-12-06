import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';

abstract class CountryRepository {
  Future<List<CountryEntity>> all();
  Future<List<CountryEntity>> banned();
}
