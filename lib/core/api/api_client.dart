import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:portafolio_yasmin/core/constants/api_constants.dart';

class ApiClient {
  static const String _baseUrlDirect = "https://api.apis.net.pe/v2";
  static const String token = "apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk";

  Future<Map<String, dynamic>?> get(String endpoint) async {
    // En web: usar proxy Cloudflare (/apisnet/...)
    // En móvil: usar API directa
    final String fullUrl = kIsWeb
        ? '${ApiConstants.proxyBaseUrl}/apisnet/$endpoint'
        : '$_baseUrlDirect/$endpoint';

    final Uri url = Uri.parse(fullUrl);

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          if (!kIsWeb) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error en la consulta API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Excepción en API: $e');
      return null;
    }
  }
}
