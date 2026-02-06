import 'package:equatable/equatable.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';

/// Estados del BLoC
/// Representan diferentes estados de la UI
abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class PersonInitial extends PersonState {
  const PersonInitial();
}

/// Estado de carga
class PersonLoading extends PersonState {
  const PersonLoading();
}

/// Estado de éxito
class PersonLoaded extends PersonState {
  final PersonEntity person;

  const PersonLoaded(this.person);

  @override
  List<Object?> get props => [person];
}

/// Estado de error
class PersonError extends PersonState {
  final String message;

  const PersonError(this.message);

  @override
  List<Object?> get props => [message];
}
