import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

class UsersViewModel extends ChangeNotifier {
  final RequstApi _api = RequstApi();

  // get list of users
  Future<List<User>> getUsers() async {
    try {
      final result = await _api.get('/api/users?page=1');

      return result.data['data']
          .map<User>((user) => User.fromJson(user))
          .toList();
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }
}
