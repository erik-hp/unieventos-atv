import '../models/evento.dart';

/// Fonte de dados fake da aplicação.
///
/// Em vez de escrever 50 eventos manualmente na tela, concentrei a geração aqui.
/// Isso deixa a interface mais limpa e simula como seria buscar dados de outro
/// lugar no futuro, como uma API ou banco de dados.
class EventoRepository {
  static const int totalEventosMock = 50;

  const EventoRepository();

  /// Gera os 50 eventos exigidos no desafio usando List.generate.
  List<Evento> listarEventos() {
    return List.generate(totalEventosMock, _gerarEvento);
  }

  /// Transforma cada posição da lista em um evento diferente.
  ///
  /// O operador % alterna entre palestra, workshop e hackathon de forma simples
  /// e previsível, sem precisar repetir muito código.
  Evento _gerarEvento(int index) {
    final id = index + 1;
    final tipo = index % 3;
    final dia = (index % 28) + 1;
    final mes = 5 + (index % 4);
    final local = _locais[index % _locais.length];
    final data =
        '${dia.toString().padLeft(2, '0')}/'
        '${mes.toString().padLeft(2, '0')}/2026 - ${14 + (index % 6)}h';
    final imagemUrl = 'https://picsum.photos/seed/unieventos-$id/900/500';

    if (tipo == 0) {
      return Evento.palestra(
        id: id,
        titulo: 'Palestra Acadêmica $id',
        data: data,
        local: local,
        imagemUrl: imagemUrl,
        descricao:
            'Encontro com professores e especialistas para discutir pesquisas, carreira acadêmica e tendências relevantes para a comunidade universitária.',
      );
    }

    if (tipo == 1) {
      return Evento.workshop(
        id: id,
        titulo: 'Workshop Prático $id',
        data: data,
        local: local,
        imagemUrl: imagemUrl,
        descricao:
            'Atividade prática com acompanhamento de monitores, exercícios guiados e aplicação direta dos conteúdos em projetos acadêmicos.',
      );
    }

    return Evento.hackathon(
      id: id,
      titulo: 'Hackathon Universitário $id',
      data: data,
      local: local,
      imagemUrl: imagemUrl,
      descricao:
          'Maratona colaborativa para criação de soluções digitais, com equipes multidisciplinares, mentoria e apresentação final dos protótipos.',
    );
  }

  /// Locais reaproveitados no mock para dar variedade aos cards.
  static const List<String> _locais = [
    'Auditório Central',
    'Laboratório de Inovação',
    'Biblioteca Universitária',
    'Sala Maker',
    'Centro de Convenções',
  ];
}
