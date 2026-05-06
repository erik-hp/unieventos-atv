import 'package:flutter/material.dart';

/// Bloco de informação usado na tela de detalhes.
///
/// Serve para destacar dados curtos como data e local, sem misturar tudo no
/// parágrafo de descrição.
class EventoInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const EventoInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Altura mínima evita que os cards fiquem desalinhados quando o texto muda.
      constraints: const BoxConstraints(minHeight: 92),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
