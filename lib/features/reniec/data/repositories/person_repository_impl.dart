import 'package:dartz/dartz.dart';
import 'package:portafolio_yasmin/core/errors/exceptions.dart';
import 'package:portafolio_yasmin/core/errors/failures.dart';
import 'package:portafolio_yasmin/core/network/network_info.dart';
import 'package:portafolio_yasmin/features/reniec/data/datasources/person_remote_datasource.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';
import 'package:portafolio_yasmin/features/reniec/domain/repositories/person_repository.dart';

/// Implementación del repositorio
/// Implementa Repository Pattern
/// Orquesta los data sources y maneja errores
/// Convierte Exceptions en Failures
class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc) async {
    return await _getPersonData(() => remoteDataSource.getPersonByRuc(ruc));
  }

  @override
  Future<Either<Failure, PersonEntity>> getFullPersonByRuc(String ruc) async {
    return await _getPersonData(() => remoteDataSource.getFullPersonByRuc(ruc));
  }

  @override
  Future<Either<Failure, PersonEntity>> getPersonByDni(String dni) async {
    // Por ahora DECOLECTA no tiene endpoint de DNI directo
    // Implementar cuando esté disponible
    return const Left(
      ServerFailure(message: 'Endpoint de DNI no disponible'),
    );
  }

  /// Método privado para manejar errores de manera consistente
  /// Implementa Template Method Pattern
  /// Either: Left = Error, Right = Success
  Future<Either<Failure, PersonEntity>> _getPersonData(
    Future<PersonEntity> Function() getPersonData,
  ) async {
    // Verificar conectividad
    if (!await networkInfo.isConnected) {
      return const Left(ConnectionFailure());
    }

    try {
      final person = await getPersonData();
      return Right(person);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    } on NetworkException catch (e) {
      return Left(
        ConnectionFailure(message: e.message),
      );
    } on ValidationException catch (e) {
      return Left(
        ValidationFailure(message: e.message),
      );
    } catch (e) {
      return Left(
        UnknownFailure(message: e.toString()),
      );
    }
  }
}
