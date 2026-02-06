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
      // Proxy CORS público para web
      const corsProxy = 'https://api.allorigins.win/raw?url=';

      // En web usar proxy CORS, en móvil usar API directa
      final String fullUrl = kIsWeb
          ? '$corsProxy${Uri.encodeComponent('${ApiConstants.decolectaBaseUrl}$endpoint')}'
          : '${ApiConstants.decolectaBaseUrl}$endpoint';

      final uri = Uri.parse(fullUrl);

      print('🌐 Realizando petición a: $uri');
      print('📱 Plataforma: ${kIsWeb ? "Web (usando proxy CORS público)" : "Nativa"}');

      final response = await client.get(
        uri,
        headers: kIsWeb
            ? {
                // En web con proxy público, solo headers básicos
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              }
            : {
                // En móvil, enviamos el token directamente
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${ApiConstants.decolectaApiKey}',
                'Accept': 'application/json',
              },
      ).timeout(ApiConstants.connectionTimeout);

      print('📥 Respuesta: ${response.statusCode}');
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
