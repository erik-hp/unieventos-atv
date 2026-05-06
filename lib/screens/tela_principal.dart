import 'package:flutter/material.dart';

import '../app/uni_eventos_app.dart';
import '../controllers/favoritos_controller.dart';
import '../models/evento.dart';
import '../repositories/evento_repository.dart';
import '../widgets/catalogo_header.dart';
import '../widgets/evento_card.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final EventoRepository _repository = const EventoRepository();
  final FavoritosController _favoritosController = FavoritosController();

  late final List<Evento> _eventos;
  bool _mostrarSomenteFavoritos = false;

  @override
  void initState() {
    super.initState();
    _eventos = _repository.listarEventos();
  }

  void _alternarFavorito(int eventoId) {
    setState(() {
      _favoritosController.alternar(eventoId);
    });
  }

  void _alternarFiltroFavoritos(bool valor) {
    setState(() {
      _mostrarSomenteFavoritos = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventosVisiveis = _mostrarSomenteFavoritos
        ? _eventos
              .where((evento) => _favoritosController.contem(evento.id))
              .toList()
        : _eventos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UniEventos'),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, size: 18),
              Switch.adaptive(
                value: _mostrarSomenteFavoritos,
                activeThumbColor: Colors.white,
                onChanged: _alternarFiltroFavoritos,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          CatalogoHeader(quantidadeEventos: eventosVisiveis.length),
          Expanded(
            child: eventosVisiveis.isEmpty
                ? const Center(
                    child: Text('Nenhum evento favoritado no momento.'),
                  )
                : ListView.builder(
                    itemCount: eventosVisiveis.length,
                    itemBuilder: (context, index) {
                      final evento = eventosVisiveis[index];
                      return EventoCard(
                        evento: evento,
                        favoritado: _favoritosController.contem(evento.id),
                        onFavoritar: () => _alternarFavorito(evento.id),
                        onAbrirDetalhes: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detalhes,
                            arguments: evento,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
