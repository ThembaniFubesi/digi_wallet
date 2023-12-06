import 'dart:convert';

import 'package:digi_wallet/core/common/data/models/country_model.dart';
import 'package:flutter/services.dart';

// Fake remote datasource
class RemoteDatasource {
  Future<List<CountryModel>> getCountries() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final data = await json.decode(response) as List;
    final countries = data.map((json) => CountryModel.fromJson(json)).toList();
    return countries;
  }
}
