import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/api_mocks.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;
  late AuthViewModel authViewModel;
  late SharedPreferences mockedPrefs;

  setUp(() async {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
    authViewModel = AuthViewModel(mockRequestApi);

    mockedPrefs = await SharedPreferences
        .getInstance(); // get shared preferences instance
  });

  group('Testing all successful network calls from auth view model', () {
    test('login function test', () async {
      apiMocks.loginApiSuccessMock();
      await authViewModel.login('test@example.com', 'password');

      expect(mockedPrefs.getBool('isLoggedIn'), true);
      expect(mockedPrefs.getString('token'), APIMocks.accessToken['token']);
    });
    test('register function test', () async {
      apiMocks.registerApiSuccessMock();
      await authViewModel.register('test@example.com', 'password');
    });

    test("log out function", () async {
      await authViewModel.logout(); // call log out function

      expect(mockedPrefs.getBool("isLoggedIn"), isNull);
      expect(mockedPrefs.getString("token"), isNull);
    });
  });
  group('Testing all unsuccessful network calls from auth view model', () {
    test('login function test', () async {
      apiMocks.loginApiFailureMock();

      expectLater(authViewModel.login('test@example.com', 'password'),
          throwsA('user not found'));
    });
    test('register function test', () async {
      apiMocks.registerApiFailureMock();
      expectLater(authViewModel.register('test@example.com', 'password'),
          throwsA('Note: only defined users succeed registration'));
    });
  });
}
