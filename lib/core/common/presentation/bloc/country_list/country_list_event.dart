part of 'country_list_bloc.dart';

sealed class CountryListEvent extends Equatable {
  const CountryListEvent();

  @override
  List<Object> get props => [];
}

class LoadCountryList extends CountryListEvent {}
