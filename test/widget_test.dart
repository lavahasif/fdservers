// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For assets, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled1/main.dart';
import 'package:untitled1/ui/MyApp.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
// $FLUTTER_ROOT/bin/cache/dart-sdk/bin/dartdoc   # on macOS or Linux
//
// %FLUTTER_ROOT%\bin\cache\dart-sdk\bin\dartdoc  # on Windows
// export FLUTTER_ROOT=~/dev/flutter  # on macOS or Linux
//
// set FLUTTER_ROOT=~/dev/flutter     # on Windows
