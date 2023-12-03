import 'package:digi_wallet/features/card/presentation/bloc/add_card/add_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart'
    as card_list;
import 'package:digi_wallet/features/card/presentation/bloc/update_card/update_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/screens/card/card_view.dart';
import 'package:digi_wallet/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardScreen extends StatelessWidget {
  final String? cardId;

  const CardScreen({super.key, this.cardId});
  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddCardBloc>(
          create: (context) => sl<AddCardBloc>(),
        ),
        BlocProvider<UpdateCardBloc>(
          create: (context) => sl<UpdateCardBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddCardBloc, AddCardState>(
            listener: (context, state) {
              if (state is AddCardSuccess) {
                BlocProvider.of<card_list.CardListBloc>(context).add(
                  card_list.AddCard(
                    payload: state.card,
                  ),
                );

                context.pop();
              }
            },
          ),
          BlocListener<UpdateCardBloc, UpdateCardState>(
            listener: (context, state) {
              if (state is UpdateCardSuccess) {
                BlocProvider.of<card_list.CardListBloc>(context).add(
                  card_list.UpdateCard(
                    payload: state.card,
                  ),
                );

                context.pop();
              }
            },
          ),
        ],
        child: CardView(cardId: cardId),
      ),
    );
  }

}
