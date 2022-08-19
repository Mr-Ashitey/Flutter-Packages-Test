import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/services/api_status.dart';
import 'package:packages_flutter/core/viewModels/shared_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends BaseModel {
  final RequestApi api;

  AuthViewModel(this.api);

  // login function
  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.Busy);
      final result = await api.post('/api/login', body: {
        'email': email,
        'password': password,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.data['token']);
      await prefs.setBool('isLoggedIn', true);

      setState(ViewState.Idle);
    } on Failure catch (e) {
      setState(ViewState.Idle);
      throw e.errorResponse!;
    }
  }

  // register function
  Future<void> register(String email, String password) async {
    try {
      setState(ViewState.Busy);
      await api.post('/api/register', body: {
        'email': email,
        'password': password,
      });

      setState(ViewState.Idle);
    } on Failure catch (e) {
      setState(ViewState.Idle);
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
