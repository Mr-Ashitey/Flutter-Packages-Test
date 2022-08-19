import 'package:packages_flutter/core/viewModels/shared_viewModel.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

class UsersViewModel extends BaseModel {
  final RequestApi _api = RequestApi();
  List<User>? _users = [];

  // getters
  List<User> get users => [..._users!];

  // get list of users
  Future<void> getUsers() async {
    try {
      final result = await _api.get('/api/users?page=1');

      _users =
          result.data['data'].map<User>((user) => User.fromJson(user)).toList();
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }
}
