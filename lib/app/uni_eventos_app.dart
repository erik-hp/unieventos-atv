import 'package:flutter/material.dart';

import '../screens/tela_detalhes_evento.dart';
import '../screens/tela_principal.dart';

/// Classe raiz do UniEventos.
///
/// Aqui ficam as configurações que valem para o app inteiro: título, rotas e
/// tema. Deixar isso centralizado facilita a leitura e evita repetição.
class UniEventosApp extends StatelessWidget {
  const UniEventosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventos',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.principal,
      // Rotas nomeadas, exatamente como o enunciado pediu.
      routes: {
        AppRoutes.principal: (context) => const TelaPrincipal(),
        AppRoutes.detalhes: (context) => const TelaDetalhesEvento(),
      },
      theme: AppTheme.light,
    );
  }
}

/// Nomes das rotas usados pela navegação.
///
/// Preferi constantes para evitar erros de digitação em strings como
/// "/detalhes".
class AppRoutes {
  static const principal = '/';
  static const detalhes = '/detalhes';

  const AppRoutes._();
}

/// Tema visual do aplicativo.
///
/// A cor azul foi escolhida para passar uma identidade universitária mais
/// sóbria e consistente.
class AppTheme {
  static const Color azulUniversitario = Color(0xFF0B3D91);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: azulUniversitario,
        primary: azulUniversitario,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: azulUniversitario,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  const AppTheme._();
}
