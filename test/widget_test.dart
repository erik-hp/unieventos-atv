import 'package:flutter_test/flutter_test.dart';

import 'package:flluter_1/main.dart';

void main() {
  // Teste simples de fumaça: ele garante que o app abre, monta a tela inicial e
  // exibe pelo menos um evento do mock. Não substitui testes manuais, mas ajuda
  // a perceber rapidamente se algo básico quebrou.
  testWidgets('UniEventos abre o catalogo de eventos', (tester) async {
    await tester.pumpWidget(const UniEventosApp());

    expect(find.text('UniEventos'), findsOneWidget);
    expect(find.text('Eventos acadêmicos disponíveis'), findsOneWidget);
    expect(find.text('Palestra Acadêmica 1'), findsOneWidget);
  });
}
