import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/models/resource_model.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/resource_provider/resources_view_model.dart';

import '../helpers/api_mocks.dart';

void main() {
  late APIMocks apiMocks;
  late RequestApi mockRequestApi;
  late ResourcesViewModel resourcesViewModel;

  setUp(() {
    apiMocks = APIMocks();
    mockRequestApi = RequestApi.test(dio: apiMocks.dio);
    resourcesViewModel = ResourcesViewModel.test(mockRequestApi);
  });

  test('Test success resources view model', () async {
    apiMocks.resourcesApiSuccessMock();
    await resourcesViewModel.getResources();
    expect(resourcesViewModel.resources, isA<List<Resource>>());
    expect(resourcesViewModel.resources.length, 1);
  });
  test('Test unsuccess resources view model', () async {
    apiMocks.resourcesApiFailureMock();
    expectLater(
      resourcesViewModel.getResources(),
      throwsA('not found'),
    );
  });
}
