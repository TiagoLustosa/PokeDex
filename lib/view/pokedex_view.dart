import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/bloc/pokemon_state.dart';
import 'package:pokedex/utils/capitalize_string.dart';

class PokedexView extends StatefulWidget {
  @override
  _PokedexViewState createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final _scrollController = ScrollController();
  PokemonBloc _pokemonBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _pokemonBloc = context.read<PokemonBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Pokedex'),
        ),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.pokemonListings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => BlocProvider.of<NavCubit>(context)
                        .showPokemonDetails(state.pokemonListings[index].id),
                    child: Card(
                      child: GridTile(
                        child: Column(
                          children: [
                            Text(
                              CapitalizeString.getCapitalizeString(
                                  str: state.pokemonListings[index].name),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Image.network(
                              state.pokemonListings[index].imageUrl,
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    int page = 0;
    if (_isBottom) {
      print(_isBottom);
      print(page);
      page++;
      print(page);
      _pokemonBloc.add(PokemonPageRequest(page: page));
    }
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 1);
  }
}
