import 'package:flutter/material.dart';

import '../app/uni_eventos_app.dart';
import '../controllers/favoritos_controller.dart';
import '../models/evento.dart';
import '../repositories/evento_repository.dart';
import '../widgets/catalogo_header.dart';
import '../widgets/evento_card.dart';

/// Tela inicial do app.
///
/// É aqui que o aluno vê o catálogo de eventos acadêmicos. Ela é Stateful
/// porque guarda o filtro de favoritos e precisa reagir quando o coração muda.
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
    // Criamos os eventos uma vez, no início da tela, para não recriar a lista
    // durante cada rebuild.
    _eventos = _repository.listarEventos();
  }

  /// Atualiza o estado do coração no card selecionado.
  void _alternarFavorito(int eventoId) {
    setState(() {
      _favoritosController.alternar(eventoId);
    });
  }

  /// Liga/desliga o filtro que mostra somente eventos favoritos.
  void _alternarFiltroFavoritos(bool valor) {
    setState(() {
      _mostrarSomenteFavoritos = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Esta lista muda de acordo com o Switch de favoritos.
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
                    // ListView.builder constrói os cards sob demanda, melhor
                    // para performance quando a lista cresce.
                    itemCount: eventosVisiveis.length,
                    itemBuilder: (context, index) {
                      final evento = eventosVisiveis[index];
                      return EventoCard(
                        evento: evento,
                        favoritado: _favoritosController.contem(evento.id),
                        onFavoritar: () => _alternarFavorito(evento.id),
                        onAbrirDetalhes: () {
                          // O evento selecionado é enviado inteiro para a tela
                          // de detalhes via rota nomeada.
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
