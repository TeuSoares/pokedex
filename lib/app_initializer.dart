import 'package:flutter/material.dart';
import 'package:pokedex/components/layout/splash_screen.dart';
import 'package:pokedex/core/connect.dart';
import 'package:pokedex/stores/app_store.dart';
import 'package:pokedex/stores/user_preferences_store.dart';
import 'package:pokedex/views/favorites_page.dart';
import 'package:pokedex/views/home_page.dart';
import 'package:pokedex/views/login_page.dart';
import 'package:pokedex/views/register_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitializer extends StatelessWidget {
  AppInitializer({super.key}) {
    UserPreferencesStore.getInstance().init();
    Connect.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);
    final SharedPreferences prefs = UserPreferencesStore.getPreferences();

    final logged = prefs.getBool('logged') ?? false;

    return MaterialApp(
      title: 'PokéDex',
      theme: appStore.isDarkTheme
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.red,
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.red,
            ),
      initialRoute: logged ? '/home' : '/splash_screen',
      routes: {
        '/splash_screen': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => Builder(
              builder: (BuildContext context) {
                return const HomePage();
              },
            ),
        '/favorites': (context) => Builder(
              builder: (BuildContext context) {
                return const FavoritesPage();
              },
            ),
      },
    );
  }
}
