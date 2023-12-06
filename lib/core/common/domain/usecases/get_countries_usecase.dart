import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';
import 'package:digi_wallet/core/common/domain/repositories/country_repository.dart';

class GetCountriesUseCase {
  final CountryRepository repository;

  GetCountriesUseCase({required this.repository});

  Future<List<CountryEntity>> call() {
    return repository.all();
  }
}
