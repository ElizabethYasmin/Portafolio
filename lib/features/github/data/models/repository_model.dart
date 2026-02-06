import 'package:portafolio_yasmin/features/github/domain/entities/repository_entity.dart';

class RepositoryModel extends RepositoryEntity {
  const RepositoryModel({
    required super.name,
    required super.description,
    required super.htmlUrl,
    required super.stargazersCount,
    required super.forksCount,
    required super.language,
    required super.updatedAt,
    super.isPrivate,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'] ?? '',
      description: json['description'] ?? 'Sin descripción',
      htmlUrl: json['html_url'] ?? '',
      stargazersCount: json['stargazers_count'] ?? 0,
      forksCount: json['forks_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
      updatedAt: DateTime.parse(json['updated_at']),
      isPrivate: json['private'] ?? false,
    );
  }

  RepositoryEntity toEntity() {
    return RepositoryEntity(
      name: name,
      description: description,
      htmlUrl: htmlUrl,
      stargazersCount: stargazersCount,
      forksCount: forksCount,
      language: language,
      updatedAt: updatedAt,
      isPrivate: isPrivate,
    );
  }
}
