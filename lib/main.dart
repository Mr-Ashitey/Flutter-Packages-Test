import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:packages_flutter/core/viewModels/providers.dart';
import 'package:packages_flutter/helpers/helpers_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: CustomTheme.mainTheme,
        initialRoute: isLoggedIn ? RouteNames.homeRoute : RouteNames.loginRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}
