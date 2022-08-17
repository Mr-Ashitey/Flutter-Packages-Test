import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';

import '../helpers/api_mocks.dart';
import '../helpers/pump_app.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;

  setUp(() async {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
  });

  final emailTextField = find.byKey(const Key('email'));
  final passwordTextField = find.byKey(const Key('password'));
  final registerButton = find.byType(ElevatedButton);
  final loginTextButton = find.byType(TextButton);
  testWidgets('Test Register Screen with empty body',
      (WidgetTester tester) async {
    // Test without email input
    await tester.pumpApp(Register(requestApi: mockRequestApi), null);

    await tester.enterText(passwordTextField, 'password');

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('All fields are required'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);

    // Test without password input
    await tester.pumpApp(Register(requestApi: mockRequestApi), null);

    await tester.enterText(passwordTextField, 'password');

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('All fields are required'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
  testWidgets('Test Register Screen with Success', (WidgetTester tester) async {
    await tester.pumpApp(Register(requestApi: mockRequestApi), mockRequestApi);

    apiMocks.registerApiSuccessMock();

    await tester.enterText(emailTextField, 'test@email.com');
    await tester.enterText(passwordTextField, 'password');

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('Registration successful: Login to continue'),
        findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.byType(Login), findsOneWidget);
  });
  testWidgets('Test Register Screen with Failure', (WidgetTester tester) async {
    await tester.pumpApp(Register(requestApi: mockRequestApi), null);

    apiMocks.registerApiFailureMock();

    await tester.enterText(emailTextField, 'test@email.com');
    await tester.enterText(passwordTextField, 'password');

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    expect(find.text('Note: only defined users succeed registration'),
        findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Navigate to login screen', (WidgetTester tester) async {
    await tester.pumpApp(Register(requestApi: mockRequestApi), mockRequestApi);

    await tester.tap(loginTextButton);
    await tester.pumpAndSettle();

    expect(find.byType(Login), findsOneWidget);
  });
}
