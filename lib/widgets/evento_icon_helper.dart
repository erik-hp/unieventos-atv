import 'package:flutter/material.dart';

import '../models/evento.dart';

class EventoIconHelper {
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
