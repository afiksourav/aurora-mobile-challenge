import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'widgets/error_view.dart';
import 'widgets/image_view.dart';

class RandomImageScreen extends StatefulWidget {
  const RandomImageScreen({super.key});

  @override
  State<RandomImageScreen> createState() => _RandomImageScreenState();
}

class _RandomImageScreenState extends State<RandomImageScreen> with SingleTickerProviderStateMixin {
  String? imageUrl;
  bool loading = true;
  bool error = false;
  Color backgroundColor = Colors.grey.shade200;

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _colorAnimation = ColorTween(begin: backgroundColor, end: backgroundColor).animate(_controller);

    fetchRandomImage();
  }

  Future<void> fetchRandomImage() async {
    setState(() {
      loading = true;
      error = false;
    });

    try {
      final response = await http.get(Uri.parse('https://november7-730026606190.europe-west1.run.app/image/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String url = data['url'];

        // extract dominant color from image
        final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(url));
        final Color newColor = palette.dominantColor?.color ?? Colors.grey.shade200;

        _colorAnimation = ColorTween(begin: backgroundColor, end: newColor).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

        _controller.forward(from: 0);

        setState(() {
          imageUrl = url;
          backgroundColor = newColor;
          loading = false;
          error = false;
        });
      } else {
        setState(() {
          loading = false;
          error = true;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorAnimation.value ?? backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: loading
                ? const CircularProgressIndicator()
                : error
                ? ErrorView(onRetry: fetchRandomImage)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: ImageView(imageUrl: imageUrl!)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: fetchRandomImage,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('Another', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
