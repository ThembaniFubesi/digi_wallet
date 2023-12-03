import 'package:digi_wallet/core/keys/keys.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CardForm extends StatefulWidget {
   final ValueChanged<CardEntity> saveCard;

   const CardForm({super.key, required this.saveCard});

  @override
  State<CardForm> createState() => _CardFormState();
}

class _CardFormState extends State<CardForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController issuingCountryController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: Keys.cardForm,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Name*',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the card name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: cardNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Card Number*',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the card number';
                }
                if (value.length < 12) {
                  return 'card number cannot be less than 12 digits';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              maxLength: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'CVV*',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the card cvv';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: issuingCountryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Issuing Country*',
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a country';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 150,
              child: TextButton(
                onPressed: () {
                  if (Keys.cardForm.currentState!.validate()) {
                    final cardPayload = CardEntity.fromCardForm(
                      id: const Uuid().toString(),
                      cardNumber: cardNumberController.text,
                      cvv: cvvController.text,
                      issuingCountry: issuingCountryController.text,
                      name: nameController.text,
                    );
                    widget.saveCard(cardPayload);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                ),
                child: const Text('Save Card',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
