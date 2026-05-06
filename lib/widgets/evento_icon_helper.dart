import 'package:flutter/material.dart';

import '../models/evento.dart';

/// Pequeno ajudante para traduzir uma categoria em ícone.
///
/// Coloquei separado para os cards não repetirem o mesmo switch em vários
/// lugares. É uma forma simples de reduzir duplicação.
class EventoIconHelper {
  /// Retorna o ícone visual usado para cada tipo de evento.
  static IconData categoria(CategoriaEvento categoria) {
    switch (categoria) {
      case CategoriaEvento.workshop:
        return Icons.handyman;
      case CategoriaEvento.hackathon:
        return Icons.code;
      case CategoriaEvento.palestra:
        return Icons.mic;
    }
  }

  const EventoIconHelper._();
}
