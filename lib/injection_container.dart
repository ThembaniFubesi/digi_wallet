import 'package:digi_wallet/core/common/data/datasources/remote_datasource.dart';
import 'package:digi_wallet/core/common/data/repositories/country_repository_impl.dart';
import 'package:digi_wallet/core/common/domain/repositories/country_repository.dart';
import 'package:digi_wallet/core/common/domain/usecases/get_banned_countries_usecase.dart';
import 'package:digi_wallet/core/common/domain/usecases/get_countries_usecase.dart';
import 'package:digi_wallet/core/common/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:digi_wallet/core/database/tables.dart';
import 'package:digi_wallet/core/validators/banned_country_validator.dart';
import 'package:digi_wallet/core/validators/card_exists_validator.dart';
import 'package:digi_wallet/core/validators/card_number_validator.dart';
import 'package:digi_wallet/core/validators/value_empty_validator.dart';
import 'package:digi_wallet/features/card/data/datasources/card_local_datasource.dart';
import 'package:digi_wallet/features/card/data/models/card_model.dart';
import 'package:digi_wallet/features/card/data/repositories/card_repository_impl.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';
import 'package:digi_wallet/features/card/domain/usecases/create_card_usecase.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_card_by_card_number_usecase.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_cards_usecase.dart';
import 'package:digi_wallet/features/card/domain/usecases/get_single_card_usecase.dart';
import 'package:digi_wallet/features/card/domain/usecases/remove_card_usecase.dart';
import 'package:digi_wallet/features/card/domain/usecases/update_card_usecase.dart';
import 'package:digi_wallet/features/card/presentation/bloc/add_card/add_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card/card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/remove_card/remove_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/update_card/update_card_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(CardModelAdapter());
  final cardBox = await Hive.openBox<CardModel>(Tables.cardName);

  // Dependencies
  sl.registerSingleton<CardLocalDatasource>(
      CardLocalDatasource(cardBox: cardBox));
  sl.registerSingleton<RemoteDatasource>(RemoteDatasource());

// Repositories
  sl.registerSingleton<CardRepository>(CardRepositoryImpl(datasource: sl()));
  sl.registerSingleton<CountryRepository>(
      CountryRepositoryImpl(datasource: sl()));

// UseCases
  sl.registerSingleton<GetCardsUseCase>(GetCardsUseCase(repository: sl()));
  sl.registerSingleton<CreateCardUseCase>(CreateCardUseCase(repository: sl()));
  sl.registerSingleton<UpdateCardUseCase>(UpdateCardUseCase(repository: sl()));
  sl.registerSingleton<RemoveCardUseCase>(RemoveCardUseCase(repository: sl()));
  sl.registerSingleton<GetSingleCardUseCase>(
      GetSingleCardUseCase(repository: sl()));

  sl.registerSingleton<GetCountriesUseCase>(
      GetCountriesUseCase(repository: sl()));
  sl.registerSingleton<GetBannedCountriesUseCase>(
      GetBannedCountriesUseCase(repository: sl()));
  sl.registerSingleton<GetCardByCardNumberUseCase>(
      GetCardByCardNumberUseCase(repository: sl()));

// Blocs
  sl.registerFactory<CardListBloc>(() => CardListBloc(sl()));
  sl.registerFactory<AddCardBloc>(() => AddCardBloc(sl(), sl(), sl()));
  sl.registerFactory<UpdateCardBloc>(() => UpdateCardBloc(sl(), sl(), sl()));
  sl.registerFactory<RemoveCardBloc>(() => RemoveCardBloc(sl()));
  sl.registerFactory<CardBloc>(() => CardBloc(sl()));
  sl.registerFactory<CountryListBloc>(() => CountryListBloc(sl()));

  // Validators
  sl.registerFactory<ValueEmptyValidator>(() => ValueEmptyValidator());
  sl.registerFactory<CardNumberValidator>(() => CardNumberValidator());
  sl.registerFactory<BannedCountryValidator>(
      () => BannedCountryValidator(getBannedCountriesUseCase: sl()));
  sl.registerFactory<CardExistsValidator>(
      () => CardExistsValidator(getCardByCardNumberUseCase: sl()));
}
