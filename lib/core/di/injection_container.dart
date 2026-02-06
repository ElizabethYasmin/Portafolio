import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:portafolio_yasmin/core/network/network_info.dart';
import 'package:portafolio_yasmin/features/github/data/datasources/github_remote_datasource.dart';
import 'package:portafolio_yasmin/features/reniec/data/datasources/person_remote_datasource.dart';
import 'package:portafolio_yasmin/features/reniec/data/repositories/person_repository_impl.dart';
import 'package:portafolio_yasmin/features/reniec/domain/repositories/person_repository.dart';
import 'package:portafolio_yasmin/features/reniec/domain/usecases/get_person_by_ruc.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_bloc.dart';

/// Service Locator - Singleton
/// Patrón Dependency Injection
/// GetIt gestiona todas las dependencias de la aplicación
final sl = GetIt.instance;

/// Inicializar todas las dependencias
/// Debe llamarse en main() antes de runApp()
Future<void> initializeDependencies() async {
  // ============ FEATURES ============

  // BLoC - Factory: nueva instancia cada vez
  sl.registerFactory(
    () => PersonBloc(
      getPersonByRuc: sl(),
    ),
  );

  // Use Cases - Lazy Singleton: se crea cuando se necesita
  sl.registerLazySingleton(() => GetPersonByRuc(sl()));

  // Repository - Lazy Singleton
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources - Lazy Singleton
  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<GitHubRemoteDataSource>(
    () => GitHubRemoteDataSourceImpl(client: sl()),
  );

  // ============ CORE ============

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // HTTP Client - Singleton
  sl.registerLazySingleton(() => http.Client());
}

/// Resetear dependencias (útil para testing)
Future<void> resetDependencies() async {
  await sl.reset();
}
