import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:packages_flutter/core/viewModels/resources_view_model.dart';
import 'package:packages_flutter/core/viewModels/users_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/api_request.dart';
import 'route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthViewModel(RequestApi())),
        ChangeNotifierProvider.value(value: UsersViewModel()),
        ChangeNotifierProvider.value(value: ResourcesViewModel(RequestApi())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.senTextTheme(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: isLoggedIn ? homeRoute : loginRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}
