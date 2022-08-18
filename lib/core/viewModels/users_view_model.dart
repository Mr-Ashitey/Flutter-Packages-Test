import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

class UsersViewModel with ChangeNotifier {
  final RequestApi _api;
  List<User>? _users = [];

  UsersViewModel(this._api);
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
