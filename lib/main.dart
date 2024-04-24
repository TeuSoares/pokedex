import 'package:flutter/material.dart';
import 'package:pokedex/app_initializer.dart';
import 'package:pokedex/stores/app_store.dart';
import 'package:pokedex/stores/pokemon_store.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonStore()),
        ChangeNotifierProvider(create: (_) => AppStore()),
      ],
      child: AppInitializer(),
    ),
  );
}
