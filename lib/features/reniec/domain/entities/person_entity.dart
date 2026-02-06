import 'package:equatable/equatable.dart';

/// Entidad de dominio para representar una persona
/// Independiente de la fuente de datos (API, caché, etc.)
class PersonEntity extends Equatable {
  final String numeroDocumento;
  final String razonSocial;
  final String estado;
  final String condicion;
  final String direccion;
  final String distrito;
  final String provincia;
  final String departamento;
  final bool esAgenteRetencion;
  final bool esBuenContribuyente;

  const PersonEntity({
    required this.numeroDocumento,
    required this.razonSocial,
    required this.estado,
    required this.condicion,
    required this.direccion,
    required this.distrito,
    required this.provincia,
    required this.departamento,
    this.esAgenteRetencion = false,
    this.esBuenContribuyente = false,
  });

  /// Obtener nombre completo
  String get fullName => razonSocial;

  /// Obtener dirección completa
  String get fullAddress => '$direccion, $distrito, $provincia, $departamento';

  /// Verificar si está activo
  bool get isActive => estado.toUpperCase() == 'ACTIVO';

  @override
  List<Object?> get props => [
        numeroDocumento,
        razonSocial,
        estado,
        condicion,
        direccion,
        distrito,
        provincia,
        departamento,
        esAgenteRetencion,
        esBuenContribuyente,
      ];
}
