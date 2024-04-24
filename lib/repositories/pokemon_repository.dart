import 'package:dio/dio.dart';
import 'package:pokedex/core/connect.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'dart:async';

class PokemonRepository {
  final Dio dio = Dio();
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  int qtde = 1;
  int loopLength = 10;
  List<PokemonModel> pokemons = [];

  Future<List<PokemonModel>> fetchPokemons() async {
    // Crie uma lista de Future para armazenar as solicitações
    List<Future<Response<dynamic>>> futures = [];

    for (int i = qtde; i < qtde + loopLength; i++) {
      // Adicione todas as solicitações à lista de futuros
      futures.add(dio.get('$baseUrl/$i'));
    }

    qtde += 10;

    // Espere que todas as solicitações sejam concluídas usando Future.wait
    List<Response<dynamic>> responses = await Future.wait(futures);

    // Processar todas as respostas
    for (var response in responses) {
      if (response.statusCode == 200) {
        final pokemon = PokemonModel.fromJson({
          ...response.data,
          'types': (response.data['types']
              .map((item) => item['type']['name'])
              .toList()),
          'pokemonId': response.data['id'],
          'image': response.data['sprites']['other']['dream_world']
              ['front_default']
        });
        pokemons.add(pokemon);
      }
    }

    return pokemons;
  }

  Future<List<Map<String, Object?>>> all(int userId) async {
    return await Connect.where('favorites_pokemons', 'userId = ?', [userId]);
  }

  Future<int> create(PokemonModel pokemon, int userId) async {
    final data = {
      'userId': userId,
      'pokemonId': pokemon.pokemonId,
      'name': pokemon.name,
      'image': pokemon.image,
      'weight': pokemon.weight,
      'height': pokemon.height,
      'types': pokemon.types.toString()
    };

    return await Connect.create('favorites_pokemons', data);
  }

  Future<int> delete(int pokemonId, int userId) async {
    final db = await Connect.database;
    return await db!.delete(
      'favorites_pokemons',
      where: 'pokemonId = ? AND userId = ?',
      whereArgs: [pokemonId, userId],
    );
  }
}
