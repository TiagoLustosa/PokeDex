/* count:1118
next:"https://pokeapi.co/api/v2/pokemon?offset=300&limit=100"
previous:"https://pokeapi.co/api/v2/pokemon?offset=100&limit=100"
name:"unown"
url:"https://pokeapi.co/api/v2/pokemon/201/"
name:"wobbuffet"
url:"https://pokeapi.co/api/v2/pokemon/202/"
*/

import 'package:flutter/foundation.dart';

class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  PokemonListing({
    @required this.id,
    @required this.name,
  });

  factory PokemonListing.fromjson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return PokemonListing(id: (id), name: name);
  }
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse({
    @required this.pokemonListings,
    @required this.canLoadNextPage,
  });
  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromjson(listingJson))
        .toList();
    return PokemonPageResponse(
        pokemonListings: pokemonListings, canLoadNextPage: canLoadNextPage);
  }
}
