import 'package:digi_wallet/core/database/tables.dart';
import 'package:digi_wallet/features/card/data/datasources/card_local_datasource.dart';
import 'package:digi_wallet/features/card/data/models/card_model.dart';
import 'package:digi_wallet/features/card/data/repositories/card_repository_impl.dart';
import 'package:digi_wallet/features/card/domain/repositories/card_repository.dart';
import 'package:digi_wallet/features/card/domain/usecases/create_card_usecase.dart';
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

// Repositories
  sl.registerSingleton<CardRepository>(CardRepositoryImpl(datasource: sl()));

// UseCases
  sl.registerSingleton<GetCardsUseCase>(GetCardsUseCase(repository: sl()));
  sl.registerSingleton<CreateCardUseCase>(CreateCardUseCase(repository: sl()));
  sl.registerSingleton<UpdateCardUseCase>(UpdateCardUseCase(repository: sl()));
  sl.registerSingleton<RemoveCardUseCase>(RemoveCardUseCase(repository: sl()));
  sl.registerSingleton<GetSingleCardUseCase>(
      GetSingleCardUseCase(repository: sl()));

// Blocs
  sl.registerFactory<CardListBloc>(() => CardListBloc(sl()));
  sl.registerFactory<AddCardBloc>(() => AddCardBloc(sl()));
  sl.registerFactory<UpdateCardBloc>(() => UpdateCardBloc(sl()));
  sl.registerFactory<RemoveCardBloc>(() => RemoveCardBloc(sl()));
  sl.registerFactory<CardBloc>(() => CardBloc(sl()));
}
