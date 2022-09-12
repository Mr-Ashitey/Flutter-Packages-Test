import 'dart:math';

import 'package:packages_flutter/core/viewModels/shared_viewModel.dart';

import '../models/user_model.dart';
import '../services/api_request.dart';
import '../services/api_status.dart';

class UsersViewModel extends BaseModel {
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
      setState(ViewState.busy);

      final result =
          await _api.post('/api/users', body: {"name": name, "job": job});

      String firstName = result.data['name'].split(' ').first;
      String lastName = result.data['name'].split(' ').last;
      String email =
          '${firstName.toLowerCase()}${lastName.toLowerCase()}@${result.data['job'].replaceAll(' ', '').toLowerCase()}.com';

      String avatar = generateRandomImageAvatar();
      // _users!.add(User.fromJson(result.data));
      _users!.add(User(
        id: int.tryParse(result.data['id']),
        firstName: firstName,
        lastName: lastName,
        email: email,
        avatar: avatar,
      ));
      setState(ViewState.idle);
    } on Failure catch (e) {
      setState(ViewState.idle);
      throw e.errorResponse!;
    }
  }

  String generateRandomImageAvatar() {
    int imageNumber = Random(10).nextInt(5) + 8;

    return 'https://reqres.in/img/faces/$imageNumber-image.jpg';
  }
}
