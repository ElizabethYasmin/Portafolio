import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portafolio_yasmin/core/constants/api_constants.dart';

/// Tab de GitHub - Muestra repositorios
class GitHubTab extends StatelessWidget {
  const GitHubTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(context),
          const SizedBox(height: 20),

          // Repositorios destacados (mock data por ahora)
          _buildRepositoryCard(
            name: 'portafolio_yasmin',
            description:
                'Portafolio profesional con Flutter y Clean Architecture',
            language: 'Dart',
            stars: 5,
            forks: 2,
            url: 'https://github.com/${ApiConstants.githubUsername}/portafolio_yasmin',
          ),
          const SizedBox(height: 15),
          _buildRepositoryCard(
            name: 'flutter_projects',
            description:
                'Colección de proyectos Flutter con diferentes patrones de diseño',
            language: 'Dart',
            stars: 12,
            forks: 4,
            url: 'https://github.com/${ApiConstants.githubUsername}',
          ),
          const SizedBox(height: 15),
          _buildRepositoryCard(
            name: 'clean_architecture_example',
            description:
                'Ejemplo de implementación de Clean Architecture en Flutter',
            language: 'Dart',
            stars: 8,
            forks: 3,
            url: 'https://github.com/${ApiConstants.githubUsername}',
          ),
          const SizedBox(height: 20),

          // Botón para ver todos los repositorios
          _buildViewAllButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF24292e), Color(0xFF1a1e22)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.code,
            size: 50,
            color: Colors.white,
          ),
          const SizedBox(height: 15),
          Text(
            '@${ApiConstants.githubUsername}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Flutter Developer • Open Source',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(Icons.book, 'Repos', '15'),
              _buildStatItem(Icons.star, 'Stars', '25'),
              _buildStatItem(Icons.people, 'Followers', '10'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder, color: Colors.blue, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.open_in_new, color: Colors.white70),
                onPressed: () => _launchUrl(url),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildLanguageBadge(language),
              const SizedBox(width: 15),
              _buildIconText(Icons.star_outline, stars.toString()),
              const SizedBox(width: 15),
              _buildIconText(Icons.fork_right, forks.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageBadge(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00B4D8).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF00B4D8),
          width: 1,
        ),
      ),
      child: Text(
        language,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF00B4D8),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 16),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () =>
            _launchUrl('https://github.com/${ApiConstants.githubUsername}'),
        icon: const Icon(Icons.open_in_new),
        label: const Text('Ver todos los repositorios'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF24292e),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
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
