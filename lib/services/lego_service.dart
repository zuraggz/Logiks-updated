import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:legos/models/lego_model.dart';

class LegoService {
  final String _x_api_key = "5735a599-dc02-441c-8688-b6afbcdf2fff";

  Future<List<LegoModel>> fetchAll() async {
    final url = "https://api.restful-api.dev/collections/legozz/objects";
    final uri = Uri.parse(url);
    final headers = {"x-api-key": _x_api_key};

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
}
