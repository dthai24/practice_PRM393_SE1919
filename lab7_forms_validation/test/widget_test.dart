import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Make sure this matches your actual project package name
import 'package:lab7_forms_validation/main.dart'; 

void main() {
  testWidgets('Signup form basic render test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Changed 'ResponsiveFormApp' to 'MyApp' to match main.dart
    await tester.pumpWidget(const MyApp());

    // Verify that our signup form title is present
    expect(find.text('Create Your Account'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}