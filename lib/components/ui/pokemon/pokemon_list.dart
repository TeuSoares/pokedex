import 'package:flutter/material.dart';
import 'package:pokedex/components/ui/loading.dart';
import 'package:pokedex/components/ui/pokemon/pokemon_card.dart';
import 'package:pokedex/controllers/pokemon_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonList extends StatelessWidget {
  final List<PokemonModel> pokemons;
  final ScrollController scrollController;
  final PokemonController pokemonController;

  const PokemonList({
    super.key,
    required this.pokemons,
    required this.scrollController,
    required this.pokemonController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 22, bottom: 22),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController, // Permitir rolagem horizontal
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                ...pokemons.map((pokemon) => PokemonCard(pokemon: pokemon)),
              ],
            ),
            if (pokemonController.state.value ==
                HomeState
                    .waitMorePokemons) // Adicione um indicador de carregamento se houver mais Pokémon
              const Padding(
                padding: EdgeInsets.only(bottom: 8, top: 15),
                child: Loading(),
              ),
          ],
        ),
      ),
    );
  }
}
