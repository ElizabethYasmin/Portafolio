import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:portafolio_yasmin/core/constants/api_constants.dart';
import 'package:portafolio_yasmin/core/errors/exceptions.dart';
import 'package:portafolio_yasmin/features/reniec/data/models/person_model.dart';

/// Contrato del Data Source remoto
abstract class PersonRemoteDataSource {
  Future<PersonModel> getPersonByRuc(String ruc);
  Future<PersonModel> getFullPersonByRuc(String ruc);
}

/// Implementación del Data Source remoto
/// Responsable ÚNICAMENTE de obtener datos de la API
/// No maneja lógica de negocio ni estado
class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<PersonModel> getPersonByRuc(String ruc) async {
    return await _makeRequest(
      endpoint: '${ApiConstants.rucEndpoint}?numero=$ruc',
    );
  }

  @override
  Future<PersonModel> getFullPersonByRuc(String ruc) async {
    return await _makeRequest(
      endpoint: '${ApiConstants.rucFullEndpoint}?numero=$ruc',
    );
  }

  /// Método privado para hacer peticiones HTTP
  /// Implementa DRY (Don't Repeat Yourself)
  /// En web usa proxy CORS público para evitar errores
  Future<PersonModel> _makeRequest({required String endpoint}) async {
    try {
      // En web: usar proxy Cloudflare (/decolecta/...)
      // En móvil: usar API directa
      final String baseUrl = kIsWeb
          ? '${ApiConstants.proxyBaseUrl}/decolecta'
          : ApiConstants.decolectaBaseUrl;

      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (!kIsWeb) 'Authorization': 'Bearer ${ApiConstants.decolectaApiKey}',
        },
      ).timeout(ApiConstants.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw NetworkException(message: 'Error de conexión: ${e.toString()}');
    }
  }

  /// Manejo de respuestas HTTP
  /// Implementa Single Responsibility Principle
  PersonModel _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        try {
          final jsonData = json.decode(response.body);
          return PersonModel.fromJson(jsonData);
        } catch (e) {
          throw ServerException(
            message: 'Error al parsear respuesta',
            statusCode: response.statusCode,
          );
        }

      case 400:
        throw ValidationException(
          message: 'Datos inválidos: ${response.body}',
        );

      case 401:
        throw ServerException(
          message: 'Token de autorización inválido',
          statusCode: 401,
        );

      case 404:
        throw ServerException(
          message: 'Información no encontrada',
          statusCode: 404,
        );

      case 429:
        throw ServerException(
          message: 'Límite de peticiones excedido',
          statusCode: 429,
        );

      case 500:
      case 502:
      case 503:
        throw ServerException(
          message: 'Error en el servidor',
          statusCode: response.statusCode,
        );

      default:
        throw ServerException(
          message: 'Error desconocido: ${response.statusCode}',
          statusCode: response.statusCode,
        );
    }
  }
}
