import 'package:digi_wallet/core/common/domain/enums/card_type.dart';
import 'package:digi_wallet/features/card/domain/entities/card_entity.dart';
import 'package:flutter/material.dart';

class CardPreview extends StatelessWidget {
  final CardEntity card;

  final VoidCallback? cardClicked;
  final DismissDirectionCallback? dismissCard;
  const CardPreview({
    super.key,
    required this.card,
    this.cardClicked,
    this.dismissCard,
  });

  @override
  Widget build(BuildContext context) {
    final cardIcon = _getCardTypeIcon(card.type);
    return Dismissible(
      key: Key(card.id),
      onDismissed: dismissCard,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        }
        return false;
      },
      child: InkWell(
        onTap: cardClicked,
        child: Ink(
          height: 200,
          decoration: _getDecoration(card.type),
          child: Stack(
            alignment: Alignment.center,
            children: [
              cardIcon != null
                  ? Positioned(
                      right: 20,
                      top: 20,
                      child: Image(width: 50, image: AssetImage(cardIcon)))
                  : const SizedBox(),
              Positioned(
                bottom: 60,
                left: 20,
                child: Text(
                  card.cardNumber,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(
                  card.cvv.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: Text(
                  card.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: Text(
                  card.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const Positioned(
                top: 50,
                left: 20,
                child: Image(
                  width: 50,
                  image: AssetImage('assets/images/chip.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _getCardTypeIcon(String type) {
    if (type == CardType.american.name ||
        type == CardType.visa.name ||
        type == CardType.masterCard.name) {
      return 'assets/images/$type.png';
    }
    return null;
  }

  _getDecoration(String type) {
    Color color = const Color(0xff016fd0);
    Gradient? gradient;
    if (type == CardType.visa.name) {
      gradient = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.indigo,
          Colors.deepPurple,
        ],
      );
    }

    if (type == CardType.masterCard.name) {
      gradient = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.black45,
          Colors.black38,
        ],
      );
    }
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
    );
  }
}
