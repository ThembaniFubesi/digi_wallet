enum CardType {
  masterCard,
  visa,
  american,
}

extension CardTypeExtension on CardType {
  String get name {
    switch (this) {
      case CardType.american:
        return 'american';
      case CardType.visa:
        return 'visa';
      case CardType.masterCard:
        return 'mastercard';
    }
  }
}
