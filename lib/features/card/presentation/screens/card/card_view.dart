import 'package:digi_wallet/core/keys/keys.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:digi_wallet/features/card/presentation/bloc/add_card/add_card_bloc.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController issuingCountryController =
      TextEditingController();

  String get title {
    return widget.cardId == null ? 'Add New Card' : 'View / Update Card';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: CardForm(
        saveCard: _onSaveCard,
      ),
    );
  }

  void _onSaveCard(CardEntity payload) {
    if (Keys.cardForm.currentState!.validate()) {
      BlocProvider.of<AddCardBloc>(context).add(
        AddCard(
          payload: payload,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please make sure you enter the required information'),
      ),
    );
  }
}
