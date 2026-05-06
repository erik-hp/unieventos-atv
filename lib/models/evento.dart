enum CategoriaEvento {
  palestra('Palestra'),
  workshop('Workshop'),
  hackathon('Hackathon');

  final String label;

  const CategoriaEvento(this.label);
}

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
