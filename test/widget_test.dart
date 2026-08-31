import 'package:flutter_test/flutter_test.dart';
import 'package:smart_fin/main.dart';
import 'package:smart_fin/modules/home/presentations/widgets/cards/neo_hero_card.dart';

void main() {
  testWidgets('FinWise App Smoke Test & Neo-Bank Theme Verification', (WidgetTester tester) async {
    await tester.pumpWidget(const FinWiseApp());
    await tester.pumpAndSettle();

    // Verify NeoHeroCard renders
    expect(find.byType(NeoHeroCard), findsOneWidget);

    // Verify Chi tiêu tháng này and OCR CTA
    expect(find.text('Chi tiêu tháng này'), findsOneWidget);
    expect(find.text('Quét hoá đơn OCR'), findsOneWidget);
  });
}
