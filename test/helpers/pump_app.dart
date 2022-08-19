import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:packages_flutter/core/viewModels/resources_view_model.dart';
import 'package:packages_flutter/core/viewModels/users_view_model.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';
import 'package:provider/provider.dart';

// reusable extension to build all screens
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    String route,
    RequestApi? requestApi,
  ) {
    return pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthViewModel(requestApi!)),
          ChangeNotifierProvider.value(value: UsersViewModel(requestApi)),
          ChangeNotifierProvider.value(value: ResourcesViewModel(requestApi)),
        ],
        child: MaterialApp(
          initialRoute: route,
          routes: {
            Login.routeName: (context) => const Login(),
            Register.routeName: (context) => Register(requestApi: requestApi),
            Home.routeName: (context) => Home(requestApi: requestApi),
          },
        ),
      ),
    );
  }
}
