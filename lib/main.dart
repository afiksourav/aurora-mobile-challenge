import 'package:flutter/material.dart';
import 'views/random_image_screen.dart';

void main() {
  runApp(const RandomImageApp());
}

class RandomImageApp extends StatelessWidget {
  const RandomImageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Image App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const RandomImageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
