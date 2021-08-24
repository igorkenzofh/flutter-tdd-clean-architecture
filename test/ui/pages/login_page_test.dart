import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_arch_app/ui/pages/pages.dart';

class MockLoginPresenter extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockLoginPresenter();
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets('should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

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

  testWidgets(
      'should call validate email and password method with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);
    // Popular o input email e td vez que alterar, chamar método para validar email
    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);

    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(presenter.validatePassword(password));
  });
}
