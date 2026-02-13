import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:portafolio_yasmin/core/theme/darcula_colors.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';

/// Tab de Perfil - Estilo Android Studio Darcula
class ProfileTab extends StatelessWidget {
  final PersonEntity person;

  const ProfileTab({
    super.key,
    required this.person,
  });

  bool get _hasAddress =>
      person.direccion.isNotEmpty && person.direccion != '-';

  bool get _hasLocation =>
      person.distrito.isNotEmpty && person.provincia.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        if (isWide) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainCard(),
                      const SizedBox(height: 12),
                      _buildAddressCard(),
                      const SizedBox(height: 12),
                      _buildBadges(),
                      const SizedBox(height: 12),
                      _buildAboutMe(),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _build3DModel(height: 500),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainCard(),
              const SizedBox(height: 12),
              _buildAddressCard(),
              const SizedBox(height: 12),
              _buildBadges(),
              const SizedBox(height: 12),
              _build3DModel(),
              const SizedBox(height: 12),
              _buildAboutMe(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título tipo comentario
          const Text(
            '// Información personal',
            style: TextStyle(
              fontSize: 12,
              color: DarculaColors.comment,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          _buildCodeLine('documento', person.numeroDocumento, DarculaColors.string),
          const Divider(color: DarculaColors.border, height: 20),
          _buildCodeLine('nombre', person.razonSocial, DarculaColors.string),
          const Divider(color: DarculaColors.border, height: 20),
          _buildCodeLine('condicion', person.condicion, DarculaColors.keyword),
        ],
      ),
    );
  }

  Widget _buildCodeLine(String key, String value, Color valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'val ',
          style: const TextStyle(
            fontSize: 13,
            color: DarculaColors.keyword,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          '$key ',
          style: const TextStyle(
            fontSize: 13,
            color: DarculaColors.field,
            fontFamily: 'monospace',
          ),
        ),
        const Text(
          '= ',
          style: TextStyle(
            fontSize: 13,
            color: DarculaColors.text,
            fontFamily: 'monospace',
          ),
        ),
        Expanded(
          child: Text(
            '"$value"',
            style: TextStyle(
              fontSize: 13,
              color: valueColor,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.folder_outlined, color: DarculaColors.keyword, size: 16),
              SizedBox(width: 8),
              Text(
                'Ubicacion.kt',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: DarculaColors.textBright,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _hasAddress ? person.direccion : '// Dirección no disponible en SUNAT',
            style: TextStyle(
              fontSize: 13,
              color: _hasAddress ? DarculaColors.string : DarculaColors.comment,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_hasLocation) ...[
                _buildChip(person.distrito),
                _buildChip(person.provincia),
                _buildChip(person.departamento),
              ] else ...[
                _buildChip('Lima'),
                _buildChip('Lima'),
                _buildChip('Perú'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
    final badges = <Map<String, dynamic>>[];

    if (person.esAgenteRetencion) {
      badges.add({
        'icon': Icons.account_balance,
        'label': 'Agente de Retención',
        'color': DarculaColors.number,
      });
    }

    if (person.esBuenContribuyente) {
      badges.add({
        'icon': Icons.star,
        'label': 'Buen Contribuyente',
        'color': DarculaColors.annotation,
      });
    }

    if (badges.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: badges
          .map((badge) => _buildBadge(
                icon: badge['icon'],
                label: badge['label'],
                color: badge['color'],
              ))
          .toList(),
    );
  }

  Widget _build3DModel({double height = 400}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Barra de título tipo panel
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              color: DarculaColors.backgroundLight,
              border: Border(
                bottom: BorderSide(color: DarculaColors.border, width: 1),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.view_in_ar, color: DarculaColors.keyword, size: 14),
                SizedBox(width: 8),
                Text(
                  'Preview: arana22.glb',
                  style: TextStyle(
                    fontSize: 11,
                    color: DarculaColors.textDim,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
              child: ModelViewer(
                src: 'https://portafolio001.elizabethhuanca40172.workers.dev/drive/1GR7WJ4H2SqJ25BfEtlVpKaOSDHvuDVH3',
                alt: 'Modelo 3D',
                autoRotate: true,
                autoRotateDelay: 0,
                cameraControls: true,
                interactionPrompt: InteractionPrompt.auto,
                backgroundColor: const Color(0xFF2B2B2B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMe() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarculaColors.selection,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.tabIndicator, width: 1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: DarculaColors.annotation, size: 16),
              SizedBox(width: 8),
              Text(
                '// TODO: Sobre mí',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: DarculaColors.annotation,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Desarrolladora Flutter apasionada por crear aplicaciones '
            'móviles modernas y eficientes. Especializada en arquitectura '
            'limpia, patrones de diseño y mejores prácticas.',
            style: TextStyle(
              fontSize: 13,
              color: DarculaColors.text,
              fontFamily: 'monospace',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: DarculaColors.backgroundLight,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: DarculaColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: DarculaColors.number,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
