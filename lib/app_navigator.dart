import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/view/pokedex_view.dart';
import 'package:pokedex/view/pokemon_details_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pokemonId) {
      return Navigator(
          pages: [
            MaterialPage(child: PokedexView()),
            if (pokemonId != null) MaterialPage(child: PokemonDetailsView())
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToPokedex();
            return route.didPop(result);
          });
    });
  }
}
