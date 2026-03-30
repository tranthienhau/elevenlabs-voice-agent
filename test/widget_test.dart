import 'package:flutter_test/flutter_test.dart';
import 'package:elevenlabs_voice_agent/main.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Voice Agent'), findsOneWidget);
  });
}
