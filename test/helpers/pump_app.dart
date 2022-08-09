import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';

// reusable extension to build all screens
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        // initialRoute: LoginScreen.routeName,
        routes: {
          Login.routeName: (context) => const Login(),
          Register.routeName: (context) => const Register(),
          Home.routeName: (context) => const Home(),
        },
      ),
    );
  }
}
