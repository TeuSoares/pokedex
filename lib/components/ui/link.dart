import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  final String text;
  final String description;
  final String route;

  const Link(
      {super.key,
      required this.text,
      required this.route,
      this.description = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            if (description != '')
              Text(description,
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
            Text(text,
                style: const TextStyle(color: Colors.blue, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
