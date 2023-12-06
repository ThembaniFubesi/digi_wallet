import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';
import 'package:digi_wallet/core/common/domain/usecases/get_countries_usecase.dart';
import 'package:equatable/equatable.dart';

part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final GetCountriesUseCase _getCountriesUseCase;

  CountryListBloc(this._getCountriesUseCase) : super(CountryListInitial()) {
    on<LoadCountryList>(_load);
  }

  FutureOr<void> _load(
    LoadCountryList event,
    Emitter<CountryListState> emit,
  ) async {
    emit(CountryListLoading());

    final countries = await _getCountriesUseCase();
    emit(CountryListLoaded(countryList: countries));
  }
}
