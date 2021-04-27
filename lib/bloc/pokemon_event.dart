import 'package:flutter/foundation.dart';

abstract class PokemonEvent {
  int get page {
    return page;
  }
}

class PokemonPageRequest extends PokemonEvent {
  final int page;

  PokemonPageRequest({
    @required this.page,
  });
}
