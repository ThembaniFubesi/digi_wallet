import 'package:digi_wallet/core/router/router.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart';
import 'package:digi_wallet/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardListBloc>(
      create: (context) => sl<CardListBloc>()..add(LoadCardList()),
      child: MaterialApp.router(
        title: 'Digi Wallet',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        routerDelegate: _appRouter.router.routerDelegate,
        routeInformationParser: _appRouter.router.routeInformationParser,
        routeInformationProvider: _appRouter.router.routeInformationProvider,
      ),
    );
  }
}
