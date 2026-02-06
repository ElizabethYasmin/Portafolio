import 'package:dartz/dartz.dart';
import 'package:portafolio_yasmin/core/errors/failures.dart';

/// Clase abstracta para todos los casos de uso
/// Implementa el patrón Command
/// Tipo T: tipo de retorno
/// Tipo Params: parámetros de entrada
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Para casos de uso sin parámetros
class NoParams {
  const NoParams();
}
