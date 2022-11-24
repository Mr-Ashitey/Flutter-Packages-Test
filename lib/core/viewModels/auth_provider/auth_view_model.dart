import 'package:packages_flutter/core/core_export.dart';

class AuthViewModel extends BaseModel {
  final RequestApi _api;

  // main constructor for actual app
  AuthViewModel() : _api = RequestApi();

  // named constructor for testing
  AuthViewModel.test(api)
      : assert(api is RequestApi),
        _api = api;

  // login function
  Future<void> login(String email, String password) async {
    try {
      setState(ViewState.busy);
      final result = await _api.post('/api/login', body: {
        'email': email,
        'password': password,
      });

      await PrefUtils.setToken(result.data['token']);
      await PrefUtils.setIsLoggedIn();

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
  Future<void> logout() async => PrefUtils.clearPreferencesData();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.remove('isLoggedIn');
  // await prefs.remove('token');

}
