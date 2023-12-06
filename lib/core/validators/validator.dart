import 'dart:async';

abstract class Validator {
  final String? message;

  Validator({this.message});

  FutureOr<String?> validate(String? value);
}
