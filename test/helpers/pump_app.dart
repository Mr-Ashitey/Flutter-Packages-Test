import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';

// reusable extension to build all screens
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget,
    RequestApi? requestApi,
  ) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        // initialRoute: LoginScreen.routeName,
        routes: {
          Login.routeName: (context) => Login(requestApi: requestApi!),
          Register.routeName: (context) => const Register(),
          Home.routeName: (context) => const Home(),
        },
      ),
    );
  }
}
