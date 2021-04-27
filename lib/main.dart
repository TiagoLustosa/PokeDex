import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app_navigator.dart';
import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon_details_cubit.dart';
import 'package:pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/view/pokedex_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pokemonDetailsCubit = PokemonDetailsCubit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Theme.of(context).copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        textTheme: TextTheme(
          headline5: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          headline6: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PokemonBloc()..add(PokemonPageRequest(page: 0)),
          ),
          BlocProvider(
            create: (context) =>
                NavCubit(pokemonDetailsCubit: pokemonDetailsCubit),
          ),
          BlocProvider(create: (context) => pokemonDetailsCubit),
        ],
        child: AppNavigator(),
      ),
    );
  }
}
