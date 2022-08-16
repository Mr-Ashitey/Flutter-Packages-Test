import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/services/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel {
  final RequestApi api;

  AuthViewModel(this.api);

  // login function
  Future<void> login(String email, String password) async {
    try {
      final result = await api.post('/api/login', body: {
        'email': email,
        'password': password,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.data['token']);
      await prefs.setBool('isLoggedIn', true);
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }

  // register function
  Future<void> register(String email, String password) async {
    try {
      await api.post('/api/register', body: {
        'email': email,
        'password': password,
      });
    } on Failure catch (e) {
      throw e.errorResponse!;
    }
  }

  // logout function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('token');
  }
}
