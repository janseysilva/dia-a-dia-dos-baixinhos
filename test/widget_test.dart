import 'package:flutter_test/flutter_test.dart';

import 'package:rotina_kids/main.dart';

void main() {
  testWidgets('Mostra a tela de escolher personagem no primeiro uso', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Escolha seu personagem!'), findsOneWidget);
  });
}
