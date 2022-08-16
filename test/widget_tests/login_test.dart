import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/services/api_request.dart';
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
  testWidgets('Test Login Screen', (WidgetTester tester) async {
    await tester.pumpApp(Login(requestApi: mockRequestApi), null);
    await tester.pump();
  });
}
