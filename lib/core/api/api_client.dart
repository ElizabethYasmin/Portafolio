import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "https://api.apis.net.pe/v2";
  static const String token = "apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk"; // Reemplázalo con tu token real

  Future<Map<String, dynamic>?> get(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error en la consulta API: ${response.statusCode}');
      return null;
    }
  }
}
