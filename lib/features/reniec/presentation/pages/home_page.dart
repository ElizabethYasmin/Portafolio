import 'package:flutter/material.dart';
import 'package:portafolio_yasmin/core/theme/darcula_colors.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/widgets/profile_tab.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/widgets/github_tab.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/widgets/social_tab.dart';
import 'package:portafolio_yasmin/features/reniec/presentation/widgets/contact_tab.dart';

/// Pantalla principal - Diseño inspirado en Android Studio Darcula
class HomePage extends StatefulWidget {
  final PersonEntity person;

  const HomePage({
    super.key,
    required this.person,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarculaColors.background,
      body: Column(
        children: [
          // Toolbar superior (como Android Studio)
          _buildToolbar(),

          // TabBar (como pestañas de archivos)
          _buildTabBar(),

          // Contenido
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfileTab(person: widget.person),
                const GitHubTab(),
                const SocialTab(),
                ContactTab(person: widget.person),
              ],
            ),
          ),

          // Status bar inferior
          _buildStatusBar(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: DarculaColors.toolbar,
        border: Border(
          bottom: BorderSide(color: DarculaColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: DarculaColors.border, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  'https://avatars.githubusercontent.com/u/62725994?v=4',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: DarculaColors.panel,
                    child: const Icon(Icons.person, color: DarculaColors.text, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Nombre como "título de proyecto"
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.android, color: DarculaColors.success, size: 16),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.person.razonSocial,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: DarculaColors.textBright,
                            fontFamily: 'monospace',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'portafolio_yasmin > ${widget.person.estado}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: DarculaColors.textDim,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),

            // Status badge (como run config)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: widget.person.isActive
                    ? DarculaColors.success.withOpacity(0.15)
                    : DarculaColors.error.withOpacity(0.15),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: widget.person.isActive
                      ? DarculaColors.success
                      : DarculaColors.error,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.person.isActive ? Icons.play_arrow : Icons.stop,
                    color: widget.person.isActive
                        ? DarculaColors.success
                        : DarculaColors.error,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.person.isActive ? 'ACTIVO' : 'INACTIVO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: widget.person.isActive
                          ? DarculaColors.success
                          : DarculaColors.error,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        color: DarculaColors.backgroundLight,
        border: Border(
          bottom: BorderSide(color: DarculaColors.border, width: 1),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: const BoxDecoration(
          color: DarculaColors.background,
          border: Border(
            top: BorderSide(color: DarculaColors.tabIndicator, width: 2),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: DarculaColors.textBright,
        unselectedLabelColor: DarculaColors.textDim,
        labelStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
        ),
        tabs: const [
          Tab(
            height: 32,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person_outline, size: 14),
                SizedBox(width: 6),
                Text('Perfil.dart'),
              ],
            ),
          ),
          Tab(
            height: 32,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.code, size: 14),
                SizedBox(width: 6),
                Text('GitHub.dart'),
              ],
            ),
          ),
          Tab(
            height: 32,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.share, size: 14),
                SizedBox(width: 6),
                Text('Redes.dart'),
              ],
            ),
          ),
          Tab(
            height: 32,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email_outlined, size: 14),
                SizedBox(width: 6),
                Text('Contacto.dart'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: DarculaColors.toolbar,
        border: Border(
          top: BorderSide(color: DarculaColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: DarculaColors.success,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Build: successful',
            style: TextStyle(
              fontSize: 11,
              color: DarculaColors.textDim,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          const Text(
            'Flutter 3.x | Dart',
            style: TextStyle(
              fontSize: 11,
              color: DarculaColors.textDim,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'UTF-8',
            style: TextStyle(
              fontSize: 11,
              color: DarculaColors.textDim,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
