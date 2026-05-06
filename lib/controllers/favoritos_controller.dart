/// Controla quais eventos foram marcados como favoritos.
///
/// Separei essa regra para a tela não precisar saber como os favoritos são
/// guardados. O Set é ótimo aqui porque não permite IDs repetidos.
class FavoritosController {
  final Set<int> _idsFavoritos = {};

  /// Verifica se um evento já está favoritado.
  bool contem(int eventoId) {
    return _idsFavoritos.contains(eventoId);
  }

  /// Alterna o favorito: se já existe, remove; se não existe, adiciona.
  void alternar(int eventoId) {
    if (contem(eventoId)) {
      _idsFavoritos.remove(eventoId);
    } else {
      _idsFavoritos.add(eventoId);
    }
  }
}
