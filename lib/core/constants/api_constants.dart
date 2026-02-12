/// Constantes de configuración de APIs
/// Las API keys se pasan via --dart-define al compilar
class ApiConstants {
  ApiConstants._();

  // Proxy CORS (Cloudflare Worker) - usado en Web para evitar CORS
  static const String proxyBaseUrl = 'https://portafolio001.elizabethhuanca40172.workers.dev';

  // DECOLECTA API
  static const String decolectaBaseUrl = 'https://api.decolecta.com';
  static const String decolectaApiKey = String.fromEnvironment(
    'DECOLECTA_API_KEY',
    defaultValue: '',
  );

  // GitHub API
  static const String githubBaseUrl = 'https://api.github.com';
  static const String githubUsername = 'ElizabethYasmin';

  // LinkedIn
  static const String linkedInUrl = 'https://www.linkedin.com/in/elizabeth-yasmin-huanca-parqui-192564195/';

  // Endpoints
  static const String dniEndpoint = '/v1/sunat/ruc';
  static const String rucEndpoint = '/v1/sunat/ruc';
  static const String rucFullEndpoint = '/v1/sunat/ruc/full';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
