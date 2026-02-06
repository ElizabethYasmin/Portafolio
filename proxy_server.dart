import 'dart:io';
import 'dart:convert';

/// Servidor proxy simple para desarrollo de Flutter Web
/// Soluciona problemas de CORS al hacer peticiones a APIs externas
///
/// Uso: dart run proxy_server.dart
void main() async {
  const port = 8080;
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

  print('🚀 Proxy server ejecutándose en http://localhost:$port');
  print('📡 Redirigiendo peticiones a las APIs externas');
  print('⚠️  Solo para desarrollo - NO usar en producción');

  await for (HttpRequest request in server) {
    // Habilitar CORS
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    request.response.headers.add('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization');

    // Manejar preflight requests
    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      await request.response.close();
      continue;
    }

    try {
      // Extraer el endpoint del path
      final path = request.uri.path;
      final queryParams = request.uri.query;

      // Determinar la URL de destino
      String targetUrl;
      Map<String, String> headers = {};

      if (path.startsWith('/v1/sunat/')) {
        // API de DECOLECTA (SUNAT/RENIEC)
        targetUrl = 'https://api.decolecta.com$path';
        if (queryParams.isNotEmpty) {
          targetUrl += '?$queryParams';
        }
        headers = {
          'Authorization': 'Bearer sk_12091.ydBsh4Xhx0XBODzTTjVvrNFAtGzZB3x8',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
      } else if (path.startsWith('/sunat/')) {
        // API alternativa de APIS.NET.PE
        targetUrl = 'https://api.apis.net.pe/v2$path';
        if (queryParams.isNotEmpty) {
          targetUrl += '?$queryParams';
        }
        headers = {
          'Authorization': 'Bearer apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk',
          'Accept': 'application/json',
        };
      } else if (path.startsWith('/github/')) {
        // API de GitHub
        final githubPath = path.replaceFirst('/github/', '');
        targetUrl = 'https://api.github.com/$githubPath';
        if (queryParams.isNotEmpty) {
          targetUrl += '?$queryParams';
        }
        headers = {
          'Accept': 'application/vnd.github.v3+json',
          'User-Agent': 'Flutter-Portfolio-App',
        };
      } else {
        request.response.statusCode = HttpStatus.badRequest;
        request.response.write(json.encode({
          'error': 'Endpoint no soportado',
          'message': 'Use /v1/sunat/, /sunat/ o /github/ como prefijo'
        }));
        await request.response.close();
        continue;
      }

      print('📤 ${request.method} $targetUrl');

      // Hacer la petición a la API externa
      final client = HttpClient();
      final uri = Uri.parse(targetUrl);
      final proxyRequest = await client.getUrl(uri);

      // Copiar headers
      headers.forEach((key, value) {
        proxyRequest.headers.add(key, value);
      });

      final proxyResponse = await proxyRequest.close();
      final responseBody = await proxyResponse.transform(utf8.decoder).join();

      // Enviar respuesta al cliente
      request.response.statusCode = proxyResponse.statusCode;
      request.response.headers.contentType = ContentType.json;
      request.response.write(responseBody);

      print('✅ ${proxyResponse.statusCode} - ${responseBody.length} bytes');

    } catch (e) {
      print('❌ Error: $e');
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write(json.encode({
        'error': 'Error en el proxy',
        'message': e.toString()
      }));
    }

    await request.response.close();
  }
}
