class CountryEntity {
  final String name;
  final String code;

  CountryEntity({required this.name, required this.code});

  factory CountryEntity.fromJson(Map<String, dynamic> json) {
    return CountryEntity(
      name: json['name'],
      code: json['code'],
    );
  }
}
