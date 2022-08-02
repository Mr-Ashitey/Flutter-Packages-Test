import 'package:flutter/material.dart';
import 'package:packages_flutter/core/services/api_request.dart';

class AuthViewModel with ChangeNotifier {
  final RequstApi _api = RequstApi();

  // login function
  Future<void> login(String email, String password) async {
    try {
      final result = await _api.post('/api/login', body: {
        'email': email,
        'password': password,
      });

      print(result);

      // notifyListeners();
    } on Exception {
      rethrow;
    }
  }

  // register function
  Future<void> register(String email, String password) async {
    try {
      await _api.post('/api/register', body: {
        'email': email,
        'password': password,
      });
    } on Exception {
      rethrow;
    }
  }
}
