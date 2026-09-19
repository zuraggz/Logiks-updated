import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:legos/models/lego_model.dart';

class LegoService {
  final String _apiKey = "5735a599-dc02-441c-8688-b6afbcdf2fff";
  final baseUrl = "https://api.restful-api.dev/collections/legozz/objects";

  Future<List<LegoModel>> fetchAll() async {
    final url = baseUrl;
    final uri = Uri.parse(url);
    final headers = {"x-api-key": _apiKey};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      //List<Map<String, dynamic>>
      final list = jsonDecode(response.body) as List;
      return list
          .map((item) => LegoModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception("Failed to load legos ${response.statusCode}");
  }

  Future<void> createLego(LegoModel lego) async {
    final url = baseUrl;
    final uri = Uri.parse(url);
    final headers = {"x-api-key": _apiKey, "Content-Type": "application/json"};

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(lego.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Failed to add lego ${response.statusCode}");
    }
  }
}
