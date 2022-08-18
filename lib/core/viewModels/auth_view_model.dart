import 'package:flutter/material.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/services/api_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents the state of the view
enum ViewState { Idle, Busy }

class AuthViewModel with ChangeNotifier {
  final RequestApi api;

  AuthViewModel(this.api);

  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

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
