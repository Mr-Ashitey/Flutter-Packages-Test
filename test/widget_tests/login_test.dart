import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/helpers/constants.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
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
  final loginButton = find.byType(ElevatedButton);
  final registerTextButton = find.byType(TextButton);
  testWidgets('Test Login Screen with empty body', (WidgetTester tester) async {
    // Test without email input
    await tester.pumpApp(loginRoute, mockRequestApi);
    await tester.pump();

    await tester.enterText(passwordTextField, 'password');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('All fields are required'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);

    // Test without password input
    await tester.pumpApp(loginRoute, mockRequestApi);

    await tester.enterText(passwordTextField, 'password');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('All fields are required'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
  testWidgets('Test Login Screen with Success', (WidgetTester tester) async {
    await tester.pumpApp(loginRoute, mockRequestApi);
    await tester.pump();

    apiMocks.loginApiSuccessMock();
    APIMocks.mockSharedPreferences();

    await tester.enterText(emailTextField, 'test@email.com');
    await tester.enterText(passwordTextField, 'password');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.byType(Home), findsOneWidget);
  });
  testWidgets('Test Login Screen with Failure', (WidgetTester tester) async {
    await tester.pumpApp(loginRoute, mockRequestApi);

    apiMocks.loginApiFailureMock();

    await tester.enterText(emailTextField, 'test@email.com');
    await tester.enterText(passwordTextField, 'password');

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('user not found'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Navigate to register screen', (WidgetTester tester) async {
    await tester.pumpApp(loginRoute, mockRequestApi);

    await tester.tap(registerTextButton);
    await tester.pumpAndSettle();

    expect(find.byType(Register), findsOneWidget);
  });
}
