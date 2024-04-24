import 'package:flutter/material.dart';
import 'package:pokedex/components/ui/app_app_bar.dart';
import 'package:pokedex/components/ui/app_drawer.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const AppAppBar(),
      body: body,
    );
  }
}
