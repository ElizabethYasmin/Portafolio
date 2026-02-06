import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiClient {
  // URLs base dependiendo de la plataforma
  static const String _baseUrlDirect = "https://api.apis.net.pe/v2";

  // Opciones de proxy CORS público (elige una):
  // Opción 1: AllOrigins (recomendado)
  static const String _corsProxyUrl = "https://api.allorigins.win/raw?url=";

  // Opción 2: CORS Anywhere (requiere activación en su sitio)
  // static const String _corsProxyUrl = "https://cors-anywhere.herokuapp.com/";

  // Opción 3: Proxy CORS (ThingProxy)
  // static const String _corsProxyUrl = "https://thingproxy.freeboard.io/fetch/";

  static const String token = "apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk";

  /// Obtiene la URL base correcta según la plataforma
  /// En web usa proxy CORS público para evitar problemas de CORS
  static String get baseUrl => kIsWeb ? _corsProxyUrl : _baseUrlDirect;

  Future<Map<String, dynamic>?> get(String endpoint) async {
    // En web, construir URL con proxy CORS
    final String fullUrl = kIsWeb
        ? '$baseUrl${Uri.encodeComponent('$_baseUrlDirect/$endpoint')}'
        : '$_baseUrlDirect/$endpoint';

    final Uri url = Uri.parse(fullUrl);

    print('🌐 Realizando petición a: $url');
    print('📱 Plataforma: ${kIsWeb ? "Web (usando proxy público CORS)" : "Nativa"}');

    try {
      final response = await http.get(
        url,
        headers: kIsWeb
            ? {
                // En web con proxy, solo headers básicos
                'Accept': 'application/json',
              }
            : {
                // En móvil, enviamos el token directamente
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
              },
      );

      print('📥 Respuesta: ${response.statusCode}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('❌ Error en la consulta API: ${response.statusCode}');
        print('📄 Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('💥 Excepción en API: $e');
      return null;
    }
  }
}
