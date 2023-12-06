import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';
import 'package:digi_wallet/core/common/domain/repositories/country_repository.dart';

class GetBannedCountriesUseCase {
  final CountryRepository repository;

  GetBannedCountriesUseCase({required this.repository});

  Future<List<CountryEntity>> call() {
    return repository.banned();
  }
}
