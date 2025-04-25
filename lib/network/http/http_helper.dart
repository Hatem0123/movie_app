import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  static const String baseUrl = 'https://newsapi.org/';

  static Future<Map<String, dynamic>> getDataFromApi(

      {required String url, Map<String, String>? query})
         async {
    Uri uri = Uri.parse('$baseUrl$url').replace(queryParameters: query);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}