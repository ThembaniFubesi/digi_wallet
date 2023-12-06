import 'package:digi_wallet/core/keys/keys.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/presentation/bloc/add_card/add_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/card/card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/bloc/update_card/update_card_bloc.dart';
import 'package:digi_wallet/features/card/presentation/widgets/card_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardView extends StatefulWidget {
  final String? cardId;
  const CardView({
    super.key,
    this.cardId,
  });

  @override
  State<CardView> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardView> {
  String get title {
    return widget.cardId == null ? 'Add New Card' : 'View / Update Card';
  }

  @override
  void initState() {
    if (widget.cardId != null) {
      context.read<CardBloc>().add(LoadCard(id: widget.cardId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardState = context.watch<CardBloc>().state is CardLoaded
        ? context.watch<CardBloc>().state as CardLoaded
        : null;
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true,),
      body: SingleChildScrollView(
        child: CardForm(
          card: cardState?.card,
          saveCard: (CardEntity payload) {
            bool isCardChanged = false;
            if (cardState is CardLoaded) {
              isCardChanged = cardState.card.cardNumber != payload.cardNumber;
            }
            _onSaveCard(payload, isCardChanged);
          },
        ),
      ),
    );
  }

  void _onSaveCard(CardEntity payload, bool isCardChanged) {
    if (Keys.cardForm.currentState!.validate()) {
      if (widget.cardId == null) {
        BlocProvider.of<AddCardBloc>(context).add(
          AddCard(
            payload: payload,
          ),
        );
      } else {
        BlocProvider.of<UpdateCardBloc>(context).add(
          UpdateCard(
            isCardChanged,
            card: payload,
          ),
        );
      }

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please make sure you enter the required information'),
      ),
    );
  }
}
