import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/models/user_model.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/users_view_model.dart';

import '../helpers/api_mocks.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;
  late UsersViewModel usersViewModel;

  setUp(() {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
    usersViewModel = UsersViewModel();
  });

  test('Test success users view model', () async {
    apiMocks.usersApiSuccessMock();
    await usersViewModel.getUsers();
    expect(usersViewModel.users, isA<List<User>>());
    expect(usersViewModel.users.length, 3);
  });
  test('Test unsuccess users view model', () async {
    apiMocks.usersApiFailureMock();
    expectLater(
      usersViewModel.getUsers(),
      throwsA('not found'),
    );
  });
}
