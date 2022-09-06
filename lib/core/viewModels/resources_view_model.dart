import 'package:flutter/material.dart';
import 'package:packages_flutter/core/models/resource_model.dart';

import '../services/api_request.dart';
import '../services/api_status.dart';

class ResourcesViewModel with ChangeNotifier {
  final RequestApi _api;
  List<Resource>? _resources = [];

  // main constructor for actual app
  ResourcesViewModel() : _api = RequestApi();

  // named constructor for testing
  ResourcesViewModel.test(api) : _api = api;

  // getters
  List<Resource> get resources => [..._resources!];

  // get list of resources
  Future<void> getResources() async {
    try {
      final result = await _api.get('/api/unknown');

      _resources = result.data['data']
          .map<Resource>((resource) => Resource.fromJson(resource))
          .toList();
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }
}
