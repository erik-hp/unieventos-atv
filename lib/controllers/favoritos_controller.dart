class FavoritosController {
  final Set<int> _idsFavoritos = {};

  bool contem(int eventoId) {
    return _idsFavoritos.contains(eventoId);
  }

  void alternar(int eventoId) {
    if (contem(eventoId)) {
      _idsFavoritos.remove(eventoId);
    } else {
      _idsFavoritos.add(eventoId);
    }
  }
}
