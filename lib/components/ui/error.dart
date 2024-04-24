import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final VoidCallback onRetry;

  const Error({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onRetry,
        child: const Text('Tentar novamente!'),
      ),
    );
  }
}
