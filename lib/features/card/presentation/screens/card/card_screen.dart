import 'package:digi_wallet/core/common/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/add_card/add_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card/card_bloc.dart';
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
        BlocProvider<CountryListBloc>(
          create: (context) => sl<CountryListBloc>()..add(LoadCountryList()),
        ),
        BlocProvider<AddCardBloc>(
          create: (context) => sl<AddCardBloc>(),
        ),
        BlocProvider<UpdateCardBloc>(
          create: (context) => sl<UpdateCardBloc>(),
        ),
        BlocProvider<CardBloc>(
          create: (context) => sl<CardBloc>(),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'New card has been added. Swipe left to remove a card. Click on the card to edit'),
                    duration: Duration(seconds: 6),
                    showCloseIcon: true,
                  ),
                );
              } else if (state is AddCardFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Card has been updated. Swipe left to remove a card. Click on the card to edit'),
                    duration: Duration(seconds: 6),
                    showCloseIcon: true,
                  ),
                );
                context.pop();
              } else if (state is UpdateCardFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
          ),
        ],
        child: CardView(cardId: cardId),
      ),
    );
  }
}
