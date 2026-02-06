import 'package:dartz/dartz.dart';
import 'package:portafolio_yasmin/core/errors/failures.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';

/// Contrato del repositorio - Define QUÉ hacer, no CÓMO
/// Permite cambiar la implementación sin afectar el dominio
abstract class PersonRepository {
  /// Obtener información de una persona por DNI
  Future<Either<Failure, PersonEntity>> getPersonByDni(String dni);

  /// Obtener información de una empresa por RUC
  Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc);

  /// Obtener información completa por RUC
  Future<Either<Failure, PersonEntity>> getFullPersonByRuc(String ruc);
}
