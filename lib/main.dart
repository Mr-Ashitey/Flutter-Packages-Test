import 'package:flutter/material.dart';
import 'package:packages_flutter/core/viewModels/providers.dart';
import 'package:packages_flutter/helpers/constants.dart';
import 'package:packages_flutter/helpers/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/route_generator.dart';

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
        initialRoute: isLoggedIn ? homeRoute : loginRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}
