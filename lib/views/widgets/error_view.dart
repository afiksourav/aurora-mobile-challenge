import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const ErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 48),
        const SizedBox(height: 10),
        const Text('Failed to load image', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
      ],
    );
  }
}
