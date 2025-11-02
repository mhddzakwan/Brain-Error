// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brain_error/main.dart';

void main() {
  testWidgets('Welcome screen displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BrainErrorApp());

    // Verify that "Brain Error" text is displayed
    expect(find.text('Brain Error'), findsOneWidget);

    // Verify that the description text is displayed
    expect(find.text('Ukur kebodohannu melalui game quiz ini'), findsOneWidget);

    // Verify that the "Mulai" button is displayed
    expect(find.text('Mulai'), findsOneWidget);

    // Verify that the image is displayed (if you want to test for image)
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Tap Mulai button navigates to home screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BrainErrorApp());

    // Verify that we are on welcome screen
    expect(find.text('Brain Error'), findsOneWidget);

    // Tap the 'Mulai' button and trigger a frame.
    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();

    // Verify that we navigated to home screen
    expect(find.text('Selamat Datang di Quiz!'), findsOneWidget);
    expect(find.text('Siap mengukur kebodohan Anda?'), findsOneWidget);
  });
}
