import 'package:flutter_test/flutter_test.dart';
import 'package:voice/constants/strings.dart';
import 'package:voice/widget/error_widget.dart';

void main() {

  testWidgets('ContentErrorWidget has a message and action', (WidgetTester tester) async {
    await tester.pumpWidget(ContentErrorWidget());

    final actionFinder = find.text(Strings.label_try_again);

    expect(actionFinder, findsOneWidget);
  });
}
