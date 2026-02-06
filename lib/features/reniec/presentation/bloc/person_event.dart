import 'package:equatable/equatable.dart';

/// Eventos del BLoC
/// Representan las intenciones del usuario
abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

/// Evento: Cargar información por RUC
class LoadPersonByRucEvent extends PersonEvent {
  final String ruc;

  const LoadPersonByRucEvent(this.ruc);

  @override
  List<Object> get props => [ruc];
}

/// Evento: Resetear estado
class ResetPersonEvent extends PersonEvent {
  const ResetPersonEvent();
}
