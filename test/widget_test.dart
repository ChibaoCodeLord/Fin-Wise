import 'package:flutter_test/flutter_test.dart';
import 'package:smart_fin/main.dart';
import 'package:smart_fin/modules/home/presentations/widgets/cards/neo_hero_card.dart';
import 'package:smart_fin/modules/home/presentations/widgets/cards/neo_insight_card.dart';

void main() {
  testWidgets('FinWise App Smoke Test & Neo-Bank Theme Verification', (WidgetTester tester) async {
    await tester.pumpWidget(const FinWiseApp());
    await tester.pumpAndSettle();

    // Verify NeoHeroCard renders
    expect(find.byType(NeoHeroCard), findsOneWidget);

    // Verify Total Balance, Deposit, Transfer, Bill negotiator
    expect(find.text('Total Balance'), findsOneWidget);
    expect(find.text('Deposit'), findsOneWidget);
    expect(find.text('Transfer'), findsOneWidget);
    expect(find.byType(NeoInsightCard), findsOneWidget);
    expect(find.text('Bills & Payments'), findsOneWidget);
  });
}
