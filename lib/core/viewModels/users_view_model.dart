import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

class UsersViewModel extends ChangeNotifier {
  final RequestApi _api;
  List<User>? _users = [];

  // main constructor for actual app
  UsersViewModel() : _api = RequestApi();

  // named constructor for testing
  UsersViewModel.test(api)
      : assert(api is RequestApi),
        _api = api;

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

  // add a user
  Future addUser(String name, String job) async {
    try {
      final result =
          await _api.post('/api/users', body: {"name": name, "job": job});

      print(result);
      print(_users);
    } on Failure catch (error) {
      throw error.errorResponse!;
    }
  }
}
