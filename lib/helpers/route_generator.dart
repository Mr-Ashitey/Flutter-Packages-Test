import 'package:flutter/material.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/home/tabs/resources/add_resource.dart';
import 'package:packages_flutter/pages/views/home/tabs/users/add_user.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';

import 'constants/route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case RouteNames.loginRoute:
        return MaterialPageRoute(builder: (_) => const Login());
      case RouteNames.registerRoute:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteNames.addUserRoute:
        return MaterialPageRoute(builder: (_) => const AddUser());
      case RouteNames.addResourceRoute:
        return MaterialPageRoute(builder: (_) => const AddResource());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
