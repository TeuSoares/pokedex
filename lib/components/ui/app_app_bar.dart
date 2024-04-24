import 'package:flutter/material.dart';
import 'package:pokedex/stores/app_store.dart';
import 'package:provider/provider.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);

    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/images/pokebola.png', width: 35, height: 35),
          const SizedBox(width: 8),
          const Text('PokéDex',
              style:
                  TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        Switch(
          value: appStore.isDarkTheme,
          onChanged: (value) => {appStore.changeTheme(value)},
          activeColor: Colors.yellow,
        )
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
