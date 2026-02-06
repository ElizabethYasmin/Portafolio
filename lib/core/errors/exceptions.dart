/// Excepciones personalizadas para la capa de datos

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    required this.message,
    this.statusCode,
  });
}

class NetworkException implements Exception {
  final String message;

  NetworkException({
    this.message = 'Error de conexión',
  });
}

class CacheException implements Exception {
  final String message;

  CacheException({
    this.message = 'Error de caché',
  });
}

class ValidationException implements Exception {
  final String message;

  ValidationException({
    required this.message,
  });
}
