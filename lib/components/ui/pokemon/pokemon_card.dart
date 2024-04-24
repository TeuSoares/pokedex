import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/components/ui/pokemon/button_card.dart';
import 'package:pokedex/controllers/pokemon_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final PokemonController pokemonController = PokemonController();
    final pokemonStore = Provider.of<PokemonStore>(context);

    Widget switchButton() {
      if (pokemonStore.favoritesPokemons
          .any((pokemon) => pokemon.pokemonId == this.pokemon.pokemonId)) {
        return ButtonCard(
          icon: Icons.delete,
          iconColor: Colors.red,
          label: 'Remover',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () => {
            pokemonController.destroyFromFavorites(pokemon.pokemonId!),
            pokemonStore.removePokemonFromFavorites(pokemon)
          },
        );
      } else {
        return ButtonCard(
          icon: Icons.favorite,
          iconColor: Colors.yellow,
          label: 'Favoritar',
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          onPressed: () => {
            pokemonController.storeInFavorites(pokemon),
            pokemonStore.addPokemonInFavorites(pokemon)
          },
        );
      }
    }

    return SizedBox(
      width: 170,
      child: Card(
        elevation: 4,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  pokemon.image!,
                  width: 65,
                  height: 65,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(pokemon.name!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(pokemon.types!.join('/')),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                        'Peso: ${(pokemon.weight! * 0.1).toStringAsFixed(2)} kg')),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                      'Altura: ${(pokemon.height! * 0.1).toStringAsFixed(2)} m'),
                ),
                switchButton(),
              ],
            )),
      ),
    );
  }
}
