import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../widgets/evento_hero.dart';
import '../widgets/evento_info_card.dart';
import '../widgets/inscricao_form.dart';

/// Tela de detalhes de um evento.
///
/// Ela recebe o objeto Evento da tela principal e mostra os dados completos,
/// além do formulário de inscrição rápida.
class TelaDetalhesEvento extends StatelessWidget {
  const TelaDetalhesEvento({super.key});

  /// Feedback simples para o aluno saber que a inscrição foi registrada.
  void _mostrarSucesso(BuildContext context, Evento evento) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Inscrição realizada em ${evento.titulo}!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extração do argumento enviado por Navigator.pushNamed.
    final evento = ModalRoute.of(context)!.settings.arguments as Evento;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Evento')),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          EventoHero(evento: evento),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: EventoInfoCard(
                        icon: Icons.calendar_month,
                        label: 'Data',
                        value: evento.data,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: EventoInfoCard(
                        icon: Icons.location_on,
                        label: 'Local',
                        value: evento.local,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  'Descrição',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  evento.descricao,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'Inscrição rápida',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                InscricaoForm(
                  onInscricaoValida: (_) => _mostrarSucesso(context, evento),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
