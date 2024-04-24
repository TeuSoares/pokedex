import 'package:flutter/material.dart';

class BackgroundLayout extends StatelessWidget {
  final Widget body;

  const BackgroundLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/background_layout.jpg',
              fit: BoxFit.cover,
            )),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        body
      ],
    );
  }
}
