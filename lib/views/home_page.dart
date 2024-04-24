import 'package:flutter/material.dart';
import 'package:pokedex/components/layout/base_layout.dart';
import 'package:pokedex/components/ui/error.dart';
import 'package:pokedex/components/ui/loading.dart';
import 'package:pokedex/components/ui/pokemon/pokemon_list.dart';
import 'package:pokedex/controllers/pokemon_controller.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:pokedex/utils/helpers/route_helper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonController pokemonController = PokemonController();
  final ScrollController _scrollController = ScrollController();
  late PokemonStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pokemonStore = Provider.of<PokemonStore>(context);

    if (RouteHelper.getCurrentRouteName(context) == '/home') {
      pokemonController.loadPokemons();

      if (_pokemonStore.favoritesPokemons.isEmpty) {
        pokemonController.getAllFavorites(context);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      pokemonController.loadPokemons();
    }
  }

  Widget screenBuild() {
    final state = pokemonController.state.value;

    switch (state) {
      case HomeState.loading:
        return const Loading();
      case HomeState.error:
        return Error(onRetry: pokemonController.loadPokemons);
      case HomeState.success || HomeState.waitMorePokemons:
        return PokemonList(
          pokemons: pokemonController.pokemons,
          scrollController: _scrollController,
          pokemonController: pokemonController,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: AnimatedBuilder(
        animation: pokemonController.state,
        builder: (context, child) {
          return screenBuild();
        },
      ),
    );
  }
}
