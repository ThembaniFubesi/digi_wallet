import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:digi_wallet/core/common/domain/entities/country_entity.dart';
import 'package:digi_wallet/core/common/presentation/bloc/country_list/country_list_bloc.dart';
import 'package:digi_wallet/core/keys/keys.dart';
import 'package:digi_wallet/core/validators/card_number_validator.dart';
import 'package:digi_wallet/core/validators/value_empty_validator.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CardForm extends StatefulWidget {
  final CardEntity? card;
  final ValueChanged<CardEntity> saveCard;

  const CardForm({super.key, required this.saveCard, this.card});

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
  void didUpdateWidget(covariant CardForm oldWidget) {
    if (oldWidget.card == widget.card) {
      super.didUpdateWidget(oldWidget);
      return;
    }
    if (widget.card?.name != null) {
      nameController.text = widget.card!.name;
    }
    if (widget.card?.cardNumber != null) {
      cardNumberController.text = widget.card!.cardNumber;
    }
    if (widget.card?.cvv != null) {
      cvvController.text = widget.card!.cvv.toString();
    }
    if (widget.card?.issuingCountry != null) {
      issuingCountryController.text = widget.card!.issuingCountry;
    }
    super.didUpdateWidget(oldWidget);
  }

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
              textInputAction: TextInputAction.next,
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
              validator:
                  ValueEmptyValidator(message: 'Please enter the card name')
                      .validate,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: cardNumberController,
              textInputAction: TextInputAction.next,
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
                suffixIcon: InkWell(
                  onTap: () async {
                    var cardDetails = await CardScanner.scanCard();
                    if (cardDetails != null) {
                      cardNumberController.text = cardDetails.cardNumber;
                    }
                  },
                  child: const Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(
                      Icons.document_scanner_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              validator: CardNumberValidator().validate,
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 3,
              textInputAction: TextInputAction.next,
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
              validator:
                  ValueEmptyValidator(message: 'Please enter the card cvv')
                      .validate,
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlocBuilder<CountryListBloc, CountryListState>(
              builder: (context, state) {
                if (state is CountryListLoaded) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Issuing Country',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      items: state.countryList.map((CountryEntity country) {
                        return DropdownMenuItem(
                          value: country.code,
                          child: Text(
                            country.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      value: issuingCountryController.text.isEmpty
                          ? null
                          : issuingCountryController.text,
                      isDense: true,
                      onChanged: (String? value) {
                        issuingCountryController.text = value!;
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.expand_more,
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  );
                }
                return const SizedBox();
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
                      id: widget.card?.id ?? const Uuid().v4().toString(),
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
