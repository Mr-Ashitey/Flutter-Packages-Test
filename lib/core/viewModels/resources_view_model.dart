import 'package:packages_flutter/core/models/resource_model.dart';

import '../services/api_request.dart';
import '../services/api_status.dart';

class ResourcesViewModel {
  final RequstApi _api = RequstApi();

  // get list of resources
  Future<List<Resource>> getResources() async {
    try {
      final result = await _api.get('/api/unknown');

      return result.data['data']
          .map<Resource>((resource) => Resource.fromJson(resource))
          .toList();
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }
}
