import 'dart:async';

import 'package:digi_wallet/core/common/domain/usecases/get_banned_countries_usecase.dart';
import 'package:digi_wallet/core/validators/validator.dart';

class BannedCountryValidator extends Validator {
  final GetBannedCountriesUseCase _getBannedCountriesUseCase;

  BannedCountryValidator({
    super.message,
    required GetBannedCountriesUseCase getBannedCountriesUseCase,
  }) : _getBannedCountriesUseCase = getBannedCountriesUseCase;

  @override
  FutureOr<String?> validate(String? value) async {
    final bannedCountries = await _getBannedCountriesUseCase();
    if (bannedCountries.any((country) => country.code == value)) {
      return 'The country you selected is banned';
    }
    return null;
  }
}
