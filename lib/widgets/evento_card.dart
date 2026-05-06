import 'package:flutter/material.dart';

import '../models/evento.dart';
import 'evento_icon_helper.dart';

class EventoCard extends StatelessWidget {
  final Evento evento;
  final bool favoritado;
  final VoidCallback onFavoritar;
  final VoidCallback onAbrirDetalhes;

  const EventoCard({
    super.key,
    required this.evento,
    required this.favoritado,
    required this.onFavoritar,
    required this.onAbrirDetalhes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: _EventoThumbnail(evento: evento),
        title: Text(
          evento.titulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${evento.categoria.label} • ${evento.data}'),
            Text(evento.local, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: IconButton(
          tooltip: favoritado ? 'Remover dos favoritos' : 'Favoritar evento',
          icon: Icon(
            favoritado ? Icons.favorite : Icons.favorite_border,
            color: favoritado ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoritar,
        ),
        onTap: onAbrirDetalhes,
      ),
    );
  }
}

class _EventoThumbnail extends StatelessWidget {
  final Evento evento;

  const _EventoThumbnail({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            evento.imagemUrl,
            width: 58,
            height: 58,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 58,
                height: 58,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  EventoIconHelper.categoria(evento.categoria),
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            EventoIconHelper.categoria(evento.categoria),
            size: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
