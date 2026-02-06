import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portafolio_yasmin/features/reniec/domain/usecases/get_person_by_ruc.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_event.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/bloc/person_state.dart';

/// BLoC - Business Logic Component
/// Separa la lógica de negocio de la UI
/// Implementa el patrón BLoC
class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final GetPersonByRuc getPersonByRuc;

  PersonBloc({
    required this.getPersonByRuc,
  }) : super(const PersonInitial()) {
    // Registrar manejadores de eventos
    on<LoadPersonByRucEvent>(_onLoadPersonByRuc);
    on<ResetPersonEvent>(_onResetPerson);
  }

  /// Manejador: Cargar persona por RUC
  Future<void> _onLoadPersonByRuc(
    LoadPersonByRucEvent event,
    Emitter<PersonState> emit,
  ) async {
    // Emitir estado de carga
    emit(const PersonLoading());

    // Ejecutar caso de uso
    final failureOrPerson = await getPersonByRuc(
      GetPersonByRucParams(ruc: event.ruc),
    );

    // Manejar resultado con Either
    failureOrPerson.fold(
      // Left: Error
      (failure) => emit(PersonError(failure.message)),
      // Right: Éxito
      (person) => emit(PersonLoaded(person)),
    );
  }

  /// Manejador: Resetear estado
  void _onResetPerson(
    ResetPersonEvent event,
    Emitter<PersonState> emit,
  ) {
    emit(const PersonInitial());
  }
}
