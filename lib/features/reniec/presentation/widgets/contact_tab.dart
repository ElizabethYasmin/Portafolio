import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio_yasmin/core/theme/darcula_colors.dart';
import 'package:portafolio_yasmin/features/reniec/domain/entities/person_entity.dart';

/// Tab de Contacto - Estilo Android Studio Darcula
class ContactTab extends StatelessWidget {
  final PersonEntity person;

  const ContactTab({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          const Text(
            '// Información de contacto',
            style: TextStyle(
              fontSize: 12,
              color: DarculaColors.comment,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          _buildContactCard(
            context: context,
            icon: Icons.email_outlined,
            label: 'email',
            value: 'elizabethhuancap@gmail.com',
          ),
          const SizedBox(height: 8),
          _buildContactCard(
            context: context,
            icon: Icons.phone_outlined,
            label: 'telefono',
            value: '+51 967 794 542',
          ),
          const SizedBox(height: 8),
          _buildContactCard(
            context: context,
            icon: Icons.location_on_outlined,
            label: 'ubicacion',
            value: person.distrito.isNotEmpty
                ? '${person.distrito}, ${person.provincia}'
                : 'Lima, Perú',
          ),
          const SizedBox(height: 20),
          _buildContactForm(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarculaColors.androidGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.androidGreen.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.android, color: DarculaColors.androidGreen, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Contáctame',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: DarculaColors.textBright,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '// Disponible para nuevos proyectos',
                  style: TextStyle(
                    fontSize: 12,
                    color: DarculaColors.comment,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DarculaColors.panel,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarculaColors.border, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: DarculaColors.androidGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
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
                  '$label ',
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
                Flexible(
                  child: Text(
                    '"$value"',
                    style: const TextStyle(
                      fontSize: 13,
                      color: DarculaColors.string,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Copiado: $value',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                  backgroundColor: DarculaColors.panel,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Icon(Icons.copy, color: DarculaColors.textDim, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
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
          const Text(
            '// Envíame un mensaje',
            style: TextStyle(
              fontSize: 12,
              color: DarculaColors.comment,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField('Nombre', Icons.person_outline),
          const SizedBox(height: 10),
          _buildTextField('Email', Icons.email_outlined),
          const SizedBox(height: 10),
          _buildTextField('Mensaje', Icons.message_outlined, maxLines: 4),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Build: mensaje enviado exitosamente',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                    backgroundColor: DarculaColors.panel,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.send, size: 14),
              label: const Text(
                'run sendMessage()',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: DarculaColors.androidGreen,
                foregroundColor: DarculaColors.background,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(
        color: DarculaColors.text,
        fontFamily: 'monospace',
        fontSize: 13,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: DarculaColors.textDim,
          fontFamily: 'monospace',
          fontSize: 12,
        ),
        prefixIcon: Icon(icon, color: DarculaColors.textDim, size: 18),
        filled: true,
        fillColor: DarculaColors.backgroundLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: DarculaColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: DarculaColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: DarculaColors.androidGreen, width: 1),
        ),
      ),
    );
  }
}
