import 'package:assimt_random_image_app/core/api/api_client.dart.dart';
import 'package:flutter/material.dart';

import '../models/image_model.dart';
import '../services/color_service.dart';

class ImageController extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  final ColorService _colorService = ColorService();

  String? imageUrl;
  Color backgroundColor = Colors.grey.shade200;
  bool loading = false;
  bool error = false;

  Future<void> fetchImage() async {
    loading = true;
    error = false;
    notifyListeners();

    try {
      final ImageModel image = await _apiClient.fetchRandomImage();
      final Color color = await _colorService.getDominantColor(image.url);

      imageUrl = image.url;
      backgroundColor = color;
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      loading = false;
      notifyListeners();
    }
  }
}
