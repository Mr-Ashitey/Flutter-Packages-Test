import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/home/tabs/resources.dart';
import 'package:packages_flutter/pages/views/home/tabs/users.dart';
import 'package:packages_flutter/pages/views/login/login.dart';

import '../helpers/api_mocks.dart';
import '../helpers/pump_app.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;

  setUp(() async {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
  });

  group('Tab tests', () {
    group('users tab view', () {
      testWidgets('Home Screen builds successfully',
          (WidgetTester tester) async {
        apiMocks.usersApiSuccessMock();
        mockNetworkImagesFor(() async {
          await tester.pumpApp(
              Home(requestApi: mockRequestApi), mockRequestApi);
          await tester.pumpAndSettle();

          expect(find.byType(Users), findsOneWidget);
          expect(find.byType(Resources), findsNothing);
        });
      });
      testWidgets('tap on list item to open alert dialog and tap close button',
          (WidgetTester tester) async {
        apiMocks.usersApiSuccessMock();
        mockNetworkImagesFor(() async {
          await tester.pumpApp(
              Home(requestApi: mockRequestApi), mockRequestApi);
          await tester.pumpAndSettle();

          expect(find.byType(Users), findsOneWidget);
          expect(find.byType(Resources), findsNothing);

          await tester.tap(find.widgetWithText(ListTile, 'Michael Lawson'));
          await tester.pump();

          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.widgetWithText(AlertDialog, 'michael.lawson@reqres.in'),
              findsOneWidget);
          expect(find.text('Close'), findsOneWidget);

          await tester.tap(find.text('Close'));
          await tester.pump();
          expect(find.byType(AlertDialog), findsNothing);
        });
      });
    });

    group('resources tab', () {
      testWidgets(
          'Home Screen builds successfully on first tab and we tap second tab i.e. packages tab view',
          (WidgetTester tester) async {
        apiMocks.usersApiSuccessMock();
        mockNetworkImagesFor(() async {
          await tester.pumpApp(
              Home(requestApi: mockRequestApi), mockRequestApi);
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.inventory_rounded), findsOneWidget);
          apiMocks.resourcesApiSuccessMock();
          await tester.tap(find.byIcon(Icons.inventory_rounded));
          await tester.pumpAndSettle();

          expect(find.byType(Users), findsNothing);
          expect(find.byType(Resources), findsOneWidget);
        });
      });
      testWidgets(
          'Home Screen builds successfully on first tab and we tap second tab i.e. packages tab view but gets an error',
          (WidgetTester tester) async {
        apiMocks.usersApiSuccessMock();
        mockNetworkImagesFor(() async {
          await tester.pumpApp(
              Home(requestApi: mockRequestApi), mockRequestApi);
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.inventory_rounded), findsOneWidget);

          apiMocks.resourcesApiFailureMock();
          await tester.tap(find.byIcon(Icons.inventory_rounded));
          await tester.pumpAndSettle();

          expect(find.text('not found'), findsOneWidget);
        });
      });
    });
  });
  testWidgets('Log out to login screen', (WidgetTester tester) async {
    apiMocks.usersApiSuccessMock();
    APIMocks.mockSharedPreferences();
    mockNetworkImagesFor(() async {
      await tester.pumpApp(Home(requestApi: mockRequestApi), mockRequestApi);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text("No"), findsOneWidget);
      expect(find.text("Yes"), findsOneWidget);

      await tester.tap(find.text('Yes'));
      await tester.pump();

      expect(find.byType(Login), findsOneWidget);
    });
  });
  testWidgets('Prevent log out', (WidgetTester tester) async {
    apiMocks.usersApiSuccessMock();
    mockNetworkImagesFor(() async {
      await tester.pumpApp(Home(requestApi: mockRequestApi), mockRequestApi);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text("No"), findsOneWidget);
      expect(find.text("Yes"), findsOneWidget);

      await tester.tap(find.text('No'));
      await tester.pump();

      expect(find.byType(Login), findsNothing);
    });
  });
}
