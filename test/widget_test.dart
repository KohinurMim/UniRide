import 'package:flutter_test/flutter_test.dart';
import 'package:uni_ride/main.dart';

void main() {
  testWidgets('UniRide smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const UniRideApp());
    expect(find.text('UniRide'), findsWidgets);
  });
}
