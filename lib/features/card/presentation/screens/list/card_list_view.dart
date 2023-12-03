import 'package:digi_wallet/features/card/presentation/bloc/card_list/card_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardListView extends StatelessWidget {
  const CardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cards'), leading: context.watch<CardListBloc>().state.status == CardListStatus.loading ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator())) : const SizedBox()),
      body: BlocBuilder<CardListBloc, CardListState>(
        builder: (context, state) {
          final cards = state.cards;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return ListTile(
                      leading: Text(card.type),
                      title: Text(card.cardNumber),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Holder: ${card.name}'),
                          const SizedBox(height: 10,),
                          Text('Country: ${card.issuingCountry}'),
                        ],
                      ),
                      trailing: Text(card.cvv.toString()),
                    );
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
