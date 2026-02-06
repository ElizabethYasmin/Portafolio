import 'package:dartz/dartz.dart';
import 'package:portafolio_yasmin/core/errors/failures.dart';
import 'package:portafolio_yasmin/core/usecases/usecase.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';
import 'package:portafolio_yasmin/features/reniec/domain/repositories/person_repository.dart';

/// Caso de uso: Obtener información de persona por RUC
/// Implementa la lógica de negocio específica
/// Orquesta la llamada al repositorio
class GetPersonByRuc implements UseCase<PersonEntity, GetPersonByRucParams> {
  final PersonRepository repository;

  GetPersonByRuc(this.repository);

  @override
  Future<Either<Failure, PersonEntity>> call(GetPersonByRucParams params) async {
    // Validación de negocio
    if (params.ruc.length != 11) {
      return const Left(
        ValidationFailure(message: 'El RUC debe tener 11 dígitos'),
      );
    }

    // Delegar al repositorio
    return await repository.getPersonByRuc(params.ruc);
  }
}

/// Parámetros del caso de uso
class GetPersonByRucParams {
  final String ruc;

  const GetPersonByRucParams({required this.ruc});
}
