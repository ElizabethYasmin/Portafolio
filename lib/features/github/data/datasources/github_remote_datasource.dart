import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:portafolio_yasmin/core/constants/api_constants.dart';
import 'package:portafolio_yasmin/core/errors/exceptions.dart';
import 'package:portafolio_yasmin/features/github/data/models/repository_model.dart';

abstract class GitHubRemoteDataSource {
  Future<List<RepositoryModel>> getUserRepositories(String username);
}

class GitHubRemoteDataSourceImpl implements GitHubRemoteDataSource {
  final http.Client client;

  GitHubRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RepositoryModel>> getUserRepositories(String username) async {
    try {
      // En web: usar proxy Cloudflare (/github/...)
      // En móvil: usar API directa
      final String baseUrl = kIsWeb
          ? '${ApiConstants.proxyBaseUrl}/github'
          : ApiConstants.githubBaseUrl;

      final uri = Uri.parse(
        '$baseUrl/users/$username/repos?sort=updated&per_page=10',
      );

      final response = await client.get(
        uri,
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ).timeout(ApiConstants.connectionTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => RepositoryModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 404) {
        throw ServerException(
          message: 'Usuario no encontrado',
          statusCode: 404,
        );
      } else {
        throw ServerException(
          message: 'Error al obtener repositorios',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(message: 'Error de conexión: ${e.toString()}');
    }
  }
}
