part of 'country_list_bloc.dart';

sealed class CountryListState extends Equatable {
  const CountryListState();

  @override
  List<Object> get props => [];
}

final class CountryListInitial extends CountryListState {}

final class CountryListLoading extends CountryListState {}

final class CountryListLoaded extends CountryListState {
  final List<CountryEntity> countryList;

  const CountryListLoaded({required this.countryList});
}

final class CountryListFailed extends CountryListState {
  final String errorMessage;

  const CountryListFailed({required this.errorMessage});
}
