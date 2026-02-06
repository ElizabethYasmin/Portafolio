import 'package:equatable/equatable.dart';

/// Clase base para todos los errores de la aplicación
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Error de servidor
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

/// Error de conexión
class ConnectionFailure extends Failure {
  const ConnectionFailure({
    super.message = 'No hay conexión a internet',
  });
}

/// Error de caché
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Error al acceder a los datos locales',
  });
}

/// Error de validación
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
  });
}

/// Error desconocido
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Ha ocurrido un error desconocido',
  });
}
