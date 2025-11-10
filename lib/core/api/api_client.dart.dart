import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/image_model.dart';

class ApiClient {
  static const String baseUrl = 'https://november7-730026606190.europe-west1.run.app';

  Future<ImageModel> fetchRandomImage() async {
    final response = await http.get(Uri.parse('$baseUrl/image/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ImageModel.fromJson(data);
    } else {
      throw Exception('Failed to load image');
    }
  }
}
