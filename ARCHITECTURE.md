# 🏗️ Arquitectura del Proyecto

## 📋 Índice
- [Introducción](#introducción)
- [Clean Architecture](#clean-architecture)
- [Patrones de Diseño](#patrones-de-diseño)
- [Estructura de Carpetas](#estructura-de-carpetas)
- [Flujo de Datos](#flujo-de-datos)
- [Mejores Prácticas](#mejores-prácticas)

## 🎯 Introducción

Este portafolio está construido siguiendo los principios de **Clean Architecture** y las mejores prácticas de desarrollo de software. El objetivo es crear una aplicación mantenible, escalable y testeable.

## 🧱 Clean Architecture

La arquitectura se divide en **3 capas principales**:

### 1. Domain Layer (Capa de Dominio)
**Responsabilidad**: Contiene la lógica de negocio pura, independiente de frameworks y librerías.

```
lib/features/[feature]/domain/
├── entities/          # Entidades de negocio
├── repositories/      # Contratos de repositorios
└── usecases/         # Casos de uso
```

**Características**:
- ✅ Sin dependencias de Flutter
- ✅ Entidades inmutables
- ✅ Lógica de negocio pura
- ✅ Interfaces de repositorios

**Ejemplo**: `PersonEntity`
```dart
class PersonEntity extends Equatable {
  final String numeroDocumento;
  final String razonSocial;
  // ... más campos

  // Lógica de negocio
  bool get isActive => estado.toUpperCase() == 'ACTIVO';
}
```

### 2. Data Layer (Capa de Datos)
**Responsabilidad**: Implementa los contratos del dominio y maneja el acceso a datos.

```
lib/features/[feature]/data/
├── models/           # Modelos de datos + serialización
├── datasources/      # Fuentes de datos (API, Local)
└── repositories/     # Implementaciones de repositorios
```

**Características**:
- ✅ Implementa interfaces del dominio
- ✅ Maneja serialización/deserialización
- ✅ Gestiona fuentes de datos
- ✅ Convierte Exceptions en Failures

**Ejemplo**: `PersonModel`
```dart
class PersonModel extends PersonEntity {
  // Factory para JSON
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(/* ... */);
  }

  // Conversión a JSON
  Map<String, dynamic> toJson() { /* ... */ }
}
```

### 3. Presentation Layer (Capa de Presentación)
**Responsabilidad**: Maneja la UI y el estado de la aplicación.

```
lib/features/[feature]/presentation/
├── bloc/            # Lógica de estado (BLoC)
├── pages/           # Páginas/Pantallas
└── widgets/         # Componentes reutilizables
```

**Características**:
- ✅ Gestión de estado con BLoC
- ✅ Separación de lógica y UI
- ✅ Widgets reutilizables
- ✅ Manejo de estados: Loading, Loaded, Error

## 🎨 Patrones de Diseño

### 1. Repository Pattern
**Propósito**: Abstraer el acceso a datos.

```dart
// Contrato (Domain)
abstract class PersonRepository {
  Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc);
}

// Implementación (Data)
class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc) async {
    // Implementación...
  }
}
```

**Beneficios**:
- ✅ Desacoplamiento entre capas
- ✅ Fácil de testear (mocks)
- ✅ Cambiar fuente de datos sin afectar dominio

### 2. Dependency Injection (GetIt)
**Propósito**: Gestionar dependencias de manera centralizada.

```dart
// Registro de dependencias
sl.registerFactory(() => PersonBloc(getPersonByRuc: sl()));
sl.registerLazySingleton(() => GetPersonByRuc(sl()));
sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
  remoteDataSource: sl(),
  networkInfo: sl(),
));
```

**Beneficios**:
- ✅ Inversión de control
- ✅ Facilita testing
- ✅ Código más limpio

### 3. BLoC Pattern
**Propósito**: Separar lógica de negocio de la UI.

```dart
// Eventos
abstract class PersonEvent extends Equatable {}
class LoadPersonByRucEvent extends PersonEvent {
  final String ruc;
}

// Estados
abstract class PersonState extends Equatable {}
class PersonLoading extends PersonState {}
class PersonLoaded extends PersonState {
  final PersonEntity person;
}
class PersonError extends PersonState {
  final String message;
}

// BLoC
class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final GetPersonByRuc getPersonByRuc;

  PersonBloc({required this.getPersonByRuc}) : super(PersonInitial()) {
    on<LoadPersonByRucEvent>(_onLoadPersonByRuc);
  }
}
```

**Beneficios**:
- ✅ Separación de responsabilidades
- ✅ Código testeable
- ✅ Estado predecible

### 4. UseCase Pattern
**Propósito**: Encapsular lógica de negocio específica.

```dart
class GetPersonByRuc implements UseCase<PersonEntity, GetPersonByRucParams> {
  final PersonRepository repository;

  @override
  Future<Either<Failure, PersonEntity>> call(GetPersonByRucParams params) async {
    // Validación de negocio
    if (params.ruc.length != 11) {
      return Left(ValidationFailure(message: 'RUC inválido'));
    }

    // Delegar al repositorio
    return await repository.getPersonByRuc(params.ruc);
  }
}
```

**Beneficios**:
- ✅ Lógica reutilizable
- ✅ Fácil de mantener
- ✅ Single Responsibility

### 5. Factory Pattern
**Propósito**: Crear objetos de manera flexible.

```dart
class PersonModel {
  factory PersonModel.fromJson(Map<String, dynamic> json) { /* ... */ }
  factory PersonModel.mock() { /* ... */ }
}
```

### 6. Either Pattern (Functional Programming)
**Propósito**: Manejo de errores elegante y type-safe.

```dart
// Left = Error, Right = Success
Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc);

// Uso
final result = await getPersonByRuc(ruc);
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (person) => print('Éxito: ${person.razonSocial}'),
);
```

## 📁 Estructura de Carpetas

```
lib/
├── core/                          # Código compartido
│   ├── constants/                 # Constantes globales
│   │   └── api_constants.dart
│   ├── errors/                    # Manejo de errores
│   │   ├── exceptions.dart        # Excepciones (Data Layer)
│   │   └── failures.dart          # Failures (Domain Layer)
│   ├── network/                   # Utilidades de red
│   │   └── network_info.dart
│   ├── usecases/                  # Clase base UseCase
│   │   └── usecase.dart
│   └── di/                        # Dependency Injection
│       └── injection_container.dart
│
├── features/                      # Features de la app
│   ├── reniec/                    # Feature: Consulta RENIEC
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── person_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── person_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_person_by_ruc.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── person_model.dart
│   │   │   ├── datasources/
│   │   │   │   └── person_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── person_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── person_bloc.dart
│   │       │   ├── person_event.dart
│   │       │   └── person_state.dart
│   │       ├── pages/
│   │       │   ├── splash_screen.dart
│   │       │   └── home_page.dart
│   │       └── widgets/
│   │           ├── profile_tab.dart
│   │           ├── github_tab.dart
│   │           ├── social_tab.dart
│   │           └── contact_tab.dart
│   │
│   └── github/                    # Feature: GitHub (similar structure)
│
└── main.dart                      # Entry point
```

## 🔄 Flujo de Datos

### Flujo completo de una petición:

```
1. UI (Widget)
   └─> Dispara un evento

2. BLoC
   └─> Recibe evento
   └─> Ejecuta UseCase

3. UseCase
   └─> Valida datos de negocio
   └─> Llama al Repository

4. Repository
   └─> Verifica conectividad
   └─> Llama al DataSource
   └─> Convierte Exceptions en Failures

5. DataSource
   └─> Hace petición HTTP
   └─> Parsea JSON
   └─> Retorna Model

6. Retorno (Either<Failure, Entity>)
   └─> Repository → UseCase → BLoC
   └─> BLoC emite nuevo estado
   └─> UI se actualiza
```

### Ejemplo visual:

```
[Widget]
    ↓ (Dispara evento)
[PersonBloc]
    ↓ (Ejecuta)
[GetPersonByRuc UseCase]
    ↓ (Llama)
[PersonRepository]
    ↓ (Consulta)
[PersonRemoteDataSource]
    ↓ (HTTP Request)
[API DECOLECTA]
    ↓ (Response)
[PersonModel]
    ↓ (Convierte a Entity)
[PersonEntity]
    ↓ (Left/Right)
[PersonBloc] (emite estado)
    ↓
[Widget] (actualiza UI)
```

## ✅ Mejores Prácticas Implementadas

### 1. SOLID Principles

#### S - Single Responsibility
```dart
// ❌ MAL: Hace muchas cosas
class PersonService {
  fetchPerson() { /* HTTP + Parse + Cache + UI */ }
}

// ✅ BIEN: Responsabilidad única
class PersonRemoteDataSource {
  fetchPerson() { /* Solo HTTP */ }
}
```

#### O - Open/Closed
```dart
// Abierto para extensión, cerrado para modificación
abstract class PersonRepository {
  Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc);
}

// Podemos crear múltiples implementaciones sin modificar el contrato
class PersonRepositoryImpl implements PersonRepository { /* ... */ }
class PersonMockRepository implements PersonRepository { /* ... */ }
```

#### L - Liskov Substitution
```dart
// PersonModel puede sustituir a PersonEntity sin problemas
PersonEntity person = PersonModel.fromJson(json);
```

#### I - Interface Segregation
```dart
// Interfaces específicas, no una grande
abstract class PersonRemoteDataSource {
  Future<PersonModel> getPersonByRuc(String ruc);
}

abstract class PersonLocalDataSource {
  Future<PersonModel> getCachedPerson();
}
```

#### D - Dependency Inversion
```dart
// Dependemos de abstracciones, no de implementaciones
class PersonBloc {
  final GetPersonByRuc getPersonByRuc; // Abstracción (UseCase)

  PersonBloc({required this.getPersonByRuc});
}
```

### 2. DRY (Don't Repeat Yourself)
```dart
// Método reutilizable para todas las peticiones HTTP
Future<PersonModel> _makeRequest({required String endpoint}) async {
  // Lógica compartida
}
```

### 3. KISS (Keep It Simple, Stupid)
```dart
// Código simple y legible
bool get isActive => estado.toUpperCase() == 'ACTIVO';
```

### 4. YAGNI (You Aren't Gonna Need It)
- Solo implementamos lo necesario
- Sin código especulativo
- Sin features "por si acaso"

### 5. Separation of Concerns
- Domain: Lógica de negocio
- Data: Acceso a datos
- Presentation: UI y estado

### 6. Error Handling
```dart
// Manejo elegante con Either
result.fold(
  (failure) => emit(PersonError(failure.message)),
  (person) => emit(PersonLoaded(person)),
);
```

### 7. Immutability
```dart
// Entidades inmutables con Equatable
class PersonEntity extends Equatable {
  final String numeroDocumento;
  const PersonEntity({required this.numeroDocumento});
}
```

### 8. Type Safety
```dart
// Either proporciona type safety
Future<Either<Failure, PersonEntity>> getPersonByRuc(String ruc);
```

### 9. Testability
- Inyección de dependencias facilita mocks
- Capas desacopladas
- Lógica pura en Domain

### 10. Documentation
- Comentarios explicativos
- README detallado
- Código auto-documentado

## 🧪 Testing

### Estructura de Tests
```
test/
├── features/
│   └── reniec/
│       ├── domain/
│       │   └── usecases/
│       │       └── get_person_by_ruc_test.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── person_model_test.dart
│       │   └── repositories/
│       │       └── person_repository_impl_test.dart
│       └── presentation/
│           └── bloc/
│               └── person_bloc_test.dart
```

### Ejemplo de Test
```dart
void main() {
  late GetPersonByRuc usecase;
  late MockPersonRepository mockRepository;

  setUp(() {
    mockRepository = MockPersonRepository();
    usecase = GetPersonByRuc(mockRepository);
  });

  test('should get person from repository', () async {
    // Arrange
    when(mockRepository.getPersonByRuc(any))
        .thenAnswer((_) async => Right(tPersonEntity));

    // Act
    final result = await usecase(GetPersonByRucParams(ruc: '12345678901'));

    // Assert
    expect(result, Right(tPersonEntity));
    verify(mockRepository.getPersonByRuc('12345678901'));
  });
}
```

## 🚀 Ventajas de esta Arquitectura

1. **Mantenibilidad**: Código organizado y fácil de mantener
2. **Escalabilidad**: Fácil agregar nuevas features
3. **Testabilidad**: Capas desacopladas facilitan testing
4. **Reutilización**: Código reutilizable y modular
5. **Flexibilidad**: Fácil cambiar implementaciones
6. **Claridad**: Estructura clara y predecible
7. **Colaboración**: Equipo puede trabajar en paralelo
8. **Performance**: Separación permite optimizaciones específicas

## 📚 Referencias

- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Pattern](https://bloclibrary.dev/)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [Dependency Injection](https://pub.dev/packages/get_it)
- [Functional Programming with Dartz](https://pub.dev/packages/dartz)
