import 'package:app/app/index.dart';
import 'package:app/main.dart' as app;
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'common/index.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    't1 login failed',
    (tester) async {
      await tester.runAsync(app.main);

      await tester.openLoginPage();

      final emailTextField = find.byType(AppInput).first;
      await tester.enterText(emailTextField, 'a');
      await tester.pumpWithDuration(1.seconds);

      final passwordTextField = find.byType(AppInput).last;
      await tester.enterText(passwordTextField, 'b');
      await tester.pumpWithDuration(1.seconds);

      await tester.dismissOnScreenKeyboard();

      final loginButtonFinder = find.byType(ElevatedButton);
      expect(loginButtonFinder, findsOneWidget);
      await tester.tap(loginButtonFinder);
      await tester.pumpWithDuration(5.seconds);

      await tester.takeScreenShot(
        binding: binding,
        fileName: 't1/t1_login_failed.png',
      );
    },
    skip: false,
  );
}
