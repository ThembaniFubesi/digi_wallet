import 'package:digi_wallet/features/card/presentation/screens/list/card_list_screen.dart';
import 'package:digi_wallet/features/card/presentation/screens/card/card_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CardListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const CardScreen(),
          ),
          GoRoute(
            path: ':cardId',
            builder: (context, state) => CardScreen(
              cardId: state.pathParameters['cardId'],
            ),
          ),
        ],
      ),
    ],
    initialLocation: '/',
  );
}
