import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorService {
  Future<Color> getDominantColor(String imageUrl) async {
    final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(imageUrl));
    return palette.dominantColor?.color ?? Colors.grey.shade200;
  }
}
