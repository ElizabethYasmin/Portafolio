import 'dart:convert';
import 'package:http/http.dart' as http;

class RucService {
  static const String _baseUrl = "http://api.apis.net.pe/v2/sunat/ruc";
  static const String _token = "apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk"; // Tu Token

  Future<Map<String, dynamic>?> getRuc(String numero) async {
    Uri url = Uri.parse("$_baseUrl?numero=$numero");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": _token,
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error en la petición: $e");
      return null;
    }
  }
}
