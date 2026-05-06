/// Categorias oficiais de eventos do UniEventos.
///
/// Usei um enum para evitar textos soltos espalhados pelo código. Assim, se um
/// nome de categoria precisar mudar, fica tudo concentrado aqui.
enum CategoriaEvento {
  palestra('Palestra'),
  workshop('Workshop'),
  hackathon('Hackathon');

  final String label;

  const CategoriaEvento(this.label);
}

/// Modelo de dados principal da atividade.
///
/// Esta classe representa exatamente o que será exibido no catálogo e enviado
/// para a tela de detalhes: título, data, local, descrição e imagem.
class Evento {
  final int id;
  final String titulo;
  final String data;
  final String local;
  final String descricao;
  final String imagemUrl;
  final CategoriaEvento categoria;

  const Evento({
    required this.id,
    required this.titulo,
    required this.data,
    required this.local,
    required this.descricao,
    required this.imagemUrl,
    required this.categoria,
  });

  /// Construtor nomeado para criar uma palestra já com a categoria correta.
  Evento.palestra({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         categoria: CategoriaEvento.palestra,
       );

  /// Construtor nomeado para criar um workshop de forma mais clara no mock.
  Evento.workshop({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         categoria: CategoriaEvento.workshop,
       );

  /// Construtor nomeado para hackathons, o terceiro tipo pedido no cenário.
  Evento.hackathon({
    required int id,
    required String titulo,
    required String data,
    required String local,
    required String descricao,
    required String imagemUrl,
  }) : this(
         id: id,
         titulo: titulo,
         data: data,
         local: local,
         descricao: descricao,
         imagemUrl: imagemUrl,
         categoria: CategoriaEvento.hackathon,
       );
}
