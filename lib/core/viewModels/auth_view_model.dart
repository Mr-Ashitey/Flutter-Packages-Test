import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/services/api_status.dart';
import 'package:packages_flutter/core/viewModels/shared_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends BaseModel {
  final RequestApi _api;

  // main constructor for actual app
  AuthViewModel() : _api = RequestApi();

  // named constructor for testing
  AuthViewModel.test(api) : _api = api;

  // login function
  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.busy);
      final result = await _api.post('/api/login', body: {
        'email': email,
        'password': password,
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.data['token']);
      await prefs.setBool('isLoggedIn', true);

      setState(ViewState.idle);
    } on Failure catch (e) {
      setState(ViewState.idle);
      throw e.errorResponse!;
    }
  }

  // register function
  Future<void> register(String email, String password) async {
    try {
      setState(ViewState.busy);
      await _api.post('/api/register', body: {
        'email': email,
        'password': password,
      });

      setState(ViewState.idle);
    } on Failure catch (e) {
      setState(ViewState.idle);
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
