import 'package:flutter_test/flutter_test.dart';
import 'package:findit/main.dart';

void main() {
  testWidgets('FindItApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FindItApp());
    expect(find.text('Find What Matters'), findsOneWidget);
  });
}
