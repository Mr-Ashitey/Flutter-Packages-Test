import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';

import '../helpers/api_mocks.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;
  late AuthViewModel authViewModel;

  setUp(() {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
    authViewModel = AuthViewModel(mockRequestApi);
  });
  test('AuthView Model', () async {
    apiMocks.loginApiSuccessMock();
    await authViewModel.login('test@example.com', 'password');
  });
}
