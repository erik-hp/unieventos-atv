import 'package:flutter/material.dart';

/// Cabeçalho do catálogo de eventos.
///
/// Ele dá contexto para a lista e mostra a quantidade de eventos visíveis,
/// inclusive quando o filtro de favoritos está ligado.
class CatalogoHeader extends StatelessWidget {
  final int quantidadeEventos;

  const CatalogoHeader({super.key, required this.quantidadeEventos});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container usado para criar uma faixa visual no topo da tela.
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.school, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              // Column organiza título e subtítulo um abaixo do outro.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eventos acadêmicos disponíveis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$quantidadeEventos eventos no catálogo',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
