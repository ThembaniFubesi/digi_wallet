import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';

class CountryModel {
  final String name;
  final String code;

  CountryModel({required this.name, required this.code});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      code: json['code'],
    );
  }

  CountryEntity toEntity() => CountryEntity(
        name: name,
        code: code,
      );
}
