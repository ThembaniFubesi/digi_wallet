import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/remove_card/remove_card_bloc.dart'
    as rc;
import 'package:digi_wallet/features/card/presentation/screens/list/card_list_view.dart';
import 'package:digi_wallet/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<rc.RemoveCardBloc>(
      create: (context) => sl<rc.RemoveCardBloc>(),
      child: BlocListener<rc.RemoveCardBloc, rc.RemoveCardState>(
        listener: (context, state) {
          if (state is rc.RemoveCardSuccess) {
            BlocProvider.of<CardListBloc>(context)
                .add(RemoveCard(id: state.id));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Card has been removed'),
                duration: Duration(seconds: 2),
                showCloseIcon: true,
              ),
            );
          }
        },
        child: const CardListView(),
      ),
    );
  }
}
