// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import the app's entry point, the DI container, and the screen to be tested
import 'package:first_flutter_v1/main.dart';
import 'package:first_flutter_v1/core/di/injection_container.dart' as di;
import 'package:first_flutter_v1/features/splash/presentation/view/splash_screen.dart';

void main() {
  // It's a good practice to set up dependencies before running tests.
  // This ensures the test environment is similar to the real app environment.
  setUp(() async {
    // Reset the service locator to ensure a clean state for each test.
    await di.sl.reset();
    // Initialize all dependencies, just like in main.dart
    await di.init();
  });

  testWidgets('App starts and shows SplashScreen', (WidgetTester tester) async {
    // This test verifies that the application starts correctly and shows the
    // initial SplashScreen, which is the new entry point of the app.

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the SplashScreen is displayed.
    expect(find.byType(SplashScreen), findsOneWidget);

    // As a secondary check, verify the text on the splash screen is present.
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
