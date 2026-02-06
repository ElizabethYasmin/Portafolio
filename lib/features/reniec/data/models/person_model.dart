import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';

/// Modelo de datos - Extiende de la entidad de dominio
/// Responsable de la serialización/deserialización
/// Implementa Factory Pattern para construcción
class PersonModel extends PersonEntity {
  const PersonModel({
    required super.numeroDocumento,
    required super.razonSocial,
    required super.estado,
    required super.condicion,
    required super.direccion,
    required super.distrito,
    required super.provincia,
    required super.departamento,
    super.esAgenteRetencion,
    super.esBuenContribuyente,
  });

  /// Factory: Crear desde JSON de la API
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      numeroDocumento: json['numero_documento'] ?? '',
      razonSocial: json['razon_social'] ?? '',
      estado: json['estado'] ?? '',
      condicion: json['condicion'] ?? '',
      direccion: json['direccion'] ?? '',
      distrito: json['distrito'] ?? '',
      provincia: json['provincia'] ?? '',
      departamento: json['departamento'] ?? '',
      esAgenteRetencion: json['es_agente_retencion'] ?? false,
      esBuenContribuyente: json['es_buen_contribuyente'] ?? false,
    );
  }

  /// Convertir a JSON para enviar a la API
  Map<String, dynamic> toJson() {
    return {
      'numero_documento': numeroDocumento,
      'razon_social': razonSocial,
      'estado': estado,
      'condicion': condicion,
      'direccion': direccion,
      'distrito': distrito,
      'provincia': provincia,
      'departamento': departamento,
      'es_agente_retencion': esAgenteRetencion,
      'es_buen_contribuyente': esBuenContribuyente,
    };
  }

  /// Convertir a entidad de dominio
  PersonEntity toEntity() {
    return PersonEntity(
      numeroDocumento: numeroDocumento,
      razonSocial: razonSocial,
      estado: estado,
      condicion: condicion,
      direccion: direccion,
      distrito: distrito,
      provincia: provincia,
      departamento: departamento,
      esAgenteRetencion: esAgenteRetencion,
      esBuenContribuyente: esBuenContribuyente,
    );
  }

  /// Factory: Crear modelo de prueba
  factory PersonModel.mock() {
    return const PersonModel(
      numeroDocumento: '10722530921',
      razonSocial: 'Elizabeth Yasmin Huanca Parqui',
      estado: 'ACTIVO',
      condicion: 'HABIDO',
      direccion: 'AV. EJEMPLO NRO 123',
      distrito: 'LIMA',
      provincia: 'LIMA',
      departamento: 'LIMA',
      esAgenteRetencion: false,
      esBuenContribuyente: true,
    );
  }
}
