import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;
  const ImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.shade300,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.broken_image, size: 48, color: Colors.red),
              SizedBox(height: 8),
              Text('Image not found', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        fadeInDuration: const Duration(milliseconds: 400),
        fit: BoxFit.cover,
      ),
    );
  }
}
