import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_quizzler/main.dart';

void main() {
  testWidgets('Quizzler app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuizApp());

    // Verify that initial question is displayed.
    expect(find.text('Môn Lập trình đa nền tảng học vào sáng thứ 5?'), findsOneWidget);
  });
}
