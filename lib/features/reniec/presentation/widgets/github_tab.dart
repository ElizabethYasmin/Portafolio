import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portafolio_yasmin/core/constants/api_constants.dart';
import 'package:portafolio_yasmin/core/theme/darcula_colors.dart';

/// Tab de GitHub - Estilo Android Studio Darcula
class GitHubTab extends StatelessWidget {
  const GitHubTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          const Text(
            '// Repositorios destacados',
            style: TextStyle(
              fontSize: 12,
              color: DarculaColors.comment,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          _buildRepositoryCard(
            name: 'portafolio_yasmin',
            description: 'Portafolio profesional con Flutter y Clean Architecture',
            language: 'Dart',
            stars: 5,
            forks: 2,
            url: 'https://github.com/${ApiConstants.githubUsername}/portafolio_yasmin',
          ),
          const SizedBox(height: 8),
          _buildRepositoryCard(
            name: 'flutter_projects',
            description: 'Colección de proyectos Flutter con diferentes patrones',
            language: 'Dart',
            stars: 12,
            forks: 4,
            url: 'https://github.com/${ApiConstants.githubUsername}',
          ),
          const SizedBox(height: 8),
          _buildRepositoryCard(
            name: 'clean_architecture_example',
            description: 'Ejemplo de implementación de Clean Architecture en Flutter',
            language: 'Dart',
            stars: 8,
            forks: 3,
            url: 'https://github.com/${ApiConstants.githubUsername}',
          ),
          const SizedBox(height: 16),
          _buildViewAllButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: DarculaColors.border, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(
                'https://avatars.githubusercontent.com/u/62725994?v=4',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: DarculaColors.backgroundLight,
                  child: const Icon(Icons.code, size: 30, color: DarculaColors.text),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${ApiConstants.githubUsername}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DarculaColors.link,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Flutter Developer | Open Source',
                  style: TextStyle(
                    fontSize: 12,
                    color: DarculaColors.textDim,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildStatChip(Icons.book_outlined, 'Repos', '15'),
                    const SizedBox(width: 8),
                    _buildStatChip(Icons.star_outline, 'Stars', '25'),
                    const SizedBox(width: 8),
                    _buildStatChip(Icons.people_outline, 'Follows', '10'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: DarculaColors.backgroundLight,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: DarculaColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: DarculaColors.textDim, size: 12),
          const SizedBox(width: 4),
          Text(
            '$value $label',
            style: const TextStyle(
              fontSize: 10,
              color: DarculaColors.text,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepositoryCard({
    required String name,
    required String description,
    required String language,
    required int stars,
    required int forks,
    required String url,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder_outlined, color: DarculaColors.keyword, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: DarculaColors.link,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              InkWell(
                onTap: () => _launchUrl(url),
                child: const Icon(Icons.open_in_new, color: DarculaColors.textDim, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '// $description',
            style: const TextStyle(
              fontSize: 12,
              color: DarculaColors.comment,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildLanguageBadge(language),
              const SizedBox(width: 12),
              _buildIconText(Icons.star_outline, stars.toString()),
              const SizedBox(width: 12),
              _buildIconText(Icons.fork_right, forks.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBadge(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: DarculaColors.number.withOpacity(0.12),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: DarculaColors.number.withOpacity(0.4)),
      ),
      child: Text(
        language,
        style: const TextStyle(
          fontSize: 10,
          color: DarculaColors.number,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: DarculaColors.textDim, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: DarculaColors.textDim,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllButton() {
    return Center(
      child: InkWell(
        onTap: () => _launchUrl('https://github.com/${ApiConstants.githubUsername}'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: DarculaColors.selection,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: DarculaColors.tabIndicator, width: 1),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.open_in_new, color: DarculaColors.link, size: 14),
              SizedBox(width: 8),
              Text(
                'git remote show origin',
                style: TextStyle(
                  fontSize: 12,
                  color: DarculaColors.link,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
