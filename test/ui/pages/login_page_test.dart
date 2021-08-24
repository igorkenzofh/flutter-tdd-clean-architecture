import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';

void main() {
  testWidgets('should load with correct initial state',
      (WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget,
        reason:
            'when a textformfield has only one child (labeltext), it means it has no errors (errorText)');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget,
        reason:
            'when a textformfield has only one child (labeltext), it means it has no errors (errorText)');

    final button = tester.widget<TextButton>(find.byType(TextButton));
    expect(button.onPressed, null);
  });
}
