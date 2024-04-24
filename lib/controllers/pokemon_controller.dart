import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:pokedex/stores/user_preferences_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonController {
  List<PokemonModel> pokemons = [];
  final pokemonRepository = PokemonRepository();
  final SharedPreferences _prefs = UserPreferencesStore.getPreferences();

  final ValueNotifier<HomeState> state = ValueNotifier(HomeState.start);

  Future loadPokemons() async {
    if (pokemons.isEmpty) {
      state.value = HomeState.loading;
    } else {
      state.value = HomeState.waitMorePokemons;
    }

    try {
      pokemons = await pokemonRepository.fetchPokemons();
      state.value = HomeState.success;
    } catch (error) {
      state.value = HomeState.error;
    }
  }

  Future<void> getAllFavorites(BuildContext context) async {
    PokemonStore pokemonStore = Provider.of<PokemonStore>(context);

    final result = await pokemonRepository.all(_prefs.getInt('id')!);

    if (result.isEmpty) {
      return;
    }

    List<PokemonModel> favoritesPokemons = result.map((pokemon) {
      String typesString = pokemon['types'].toString();

      List<String> types =
          typesString.replaceAll(RegExp(r'[\[\]\s]'), '').split(',');

      return PokemonModel.fromJson({
        'userId': int.parse(pokemon['userId'].toString()),
        'pokemonId': int.parse(pokemon['pokemonId'].toString()),
        'name': pokemon['name'],
        'image': pokemon['image'],
        'weight': int.parse(pokemon['weight'].toString()),
        'height': int.parse(pokemon['height'].toString()),
        'types': types,
      });
    }).toList();

    pokemonStore.addFavoritesPokemonList(favoritesPokemons);
  }

  Future<void> storeInFavorites(PokemonModel pokemon) async {
    await pokemonRepository.create(pokemon, _prefs.getInt('id')!);
  }

  Future<void> destroyFromFavorites(int pokemonId) async {
    await pokemonRepository.delete(pokemonId, _prefs.getInt('id')!);
  }
}

enum HomeState { start, loading, waitMorePokemons, success, error }
