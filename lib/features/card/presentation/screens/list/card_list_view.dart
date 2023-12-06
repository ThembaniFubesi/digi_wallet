import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/remove_card/remove_card_bloc.dart'
    as rc;
import 'package:digi_wallet/features/card/presentation/widgets/card_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardListView extends StatelessWidget {
  const CardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Cards'),
          centerTitle: true,
          leading: context.watch<CardListBloc>().state.status ==
                  CardListStatus.loading
              ? const Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()))
              : const SizedBox()),
      body: BlocBuilder<CardListBloc, CardListState>(
        builder: (context, state) {
          final cards = state.cards;
          return Column(
            children: [
              Expanded(
                child: cards.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'No cards have been added.\n To get started, click on the button below.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];
                          return CardPreview(
                            card: cards[index],
                            cardClicked: () {
                              context.go('/${card.id}');
                            },
                            dismissCard: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                BlocProvider.of<rc.RemoveCardBloc>(context)
                                    .add(rc.RemoveCard(id: card.id));
                              }
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
