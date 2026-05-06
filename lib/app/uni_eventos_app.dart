import 'package:flutter/material.dart';

import '../screens/tela_detalhes_evento.dart';
import '../screens/tela_principal.dart';

class UniEventosApp extends StatelessWidget {
  const UniEventosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEventos',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.principal,
      routes: {
        AppRoutes.principal: (context) => const TelaPrincipal(),
        AppRoutes.detalhes: (context) => const TelaDetalhesEvento(),
      },
      theme: AppTheme.light,
    );
  }
}

class AppRoutes {
  static const principal = '/';
  static const detalhes = '/detalhes';

  const AppRoutes._();
}

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
