import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonStore extends ChangeNotifier {
  List<PokemonModel> favoritesPokemons = [];

  void addPokemonInFavorites(PokemonModel pokemon) {
    favoritesPokemons.add(pokemon);
    notifyListeners(); // Notificar os observadores sobre a mudança nos dados
  }

  void addFavoritesPokemonList(List<PokemonModel> pokemons) {
    favoritesPokemons.addAll(pokemons);
    notifyListeners();
  }

  void removePokemonFromFavorites(PokemonModel pokemon) {
    favoritesPokemons
        .removeWhere((item) => item.pokemonId == pokemon.pokemonId);
    notifyListeners();
  }

  void resetStates() {
    favoritesPokemons = [];
    notifyListeners();
  }
}
