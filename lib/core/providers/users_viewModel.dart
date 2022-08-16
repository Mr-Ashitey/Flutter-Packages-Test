import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

final usersProvider =
    StateNotifierProvider((ref) => UsersViewModel(RequestApi()));

class UsersViewModel extends StateNotifier<List<User>> {
  final RequestApi _api;

  UsersViewModel(this._api) : super([]);

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
