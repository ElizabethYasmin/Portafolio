import 'package:equatable/equatable.dart';

/// Entidad de dominio para un repositorio de GitHub
class RepositoryEntity extends Equatable {
  final String name;
  final String description;
  final String htmlUrl;
  final int stargazersCount;
  final int forksCount;
  final String language;
  final DateTime updatedAt;
  final bool isPrivate;

  const RepositoryEntity({
    required this.name,
    required this.description,
    required this.htmlUrl,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.updatedAt,
    this.isPrivate = false,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        htmlUrl,
        stargazersCount,
        forksCount,
        language,
        updatedAt,
        isPrivate,
      ];
}
