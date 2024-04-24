import 'package:flutter/material.dart';
import 'package:pokedex/components/layout/base_layout.dart';
import 'package:pokedex/components/ui/pokemon/pokemon_card.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = Provider.of<PokemonStore>(context);

    return BaseLayout(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 22, bottom: 22),
      child: pokemonStore.favoritesPokemons.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text('Meus Pokémons Favoritos',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...pokemonStore.favoritesPokemons
                              .map((pokemon) => PokemonCard(pokemon: pokemon)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
              'Você ainda não adicionou Pokémons aos seus favoritos.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
    ));
  }
}
