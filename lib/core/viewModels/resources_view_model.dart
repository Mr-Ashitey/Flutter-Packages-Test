import 'package:flutter/material.dart';
import 'package:packages_flutter/core/models/resource_model.dart';
import 'package:packages_flutter/core/viewModels/shared_viewModel.dart';

import '../services/api_request.dart';
import '../services/api_status.dart';

class ResourcesViewModel extends BaseModel {
  final RequestApi _api;
  List<Resource>? _resources = [];

  // main constructor for actual app
  ResourcesViewModel() : _api = RequestApi();

  // named constructor for testing
  ResourcesViewModel.test(api)
      : assert(api is RequestApi),
        _api = api;

  // getters
  List<Resource> get resources => [..._resources!];

  // get list of resources
  Future<void> getResources() async {
    try {
      final result = await _api.get('/api/resources');

      _resources = result.data['data']
          .map<Resource>((resource) => Resource.fromJson(resource))
          .toList();
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }

  // add resource
  Future<void> addResource(
      String name, String year, String color, String pantone) async {
    try {
      setState(ViewState.busy);
      final result = await _api.post('/api/resources', body: {
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantone
      });
      // "name": "fuchsia rose",
      // "year": 2001,
      // "color": "#C74375",
      // "pantone_value": "17-2031"
      setState(ViewState.idle);
    } on Failure catch (e) {
      setState(ViewState.idle);
      throw e.errorResponse!;
    }
  }
}
