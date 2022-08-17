import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/api_request.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.senTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isLoggedIn ? homeRoute : loginRoute,
      routes: {
        Login.routeName: (context) => Login(requestApi: RequestApi()),
        Register.routeName: (context) => Register(requestApi: RequestApi()),
        Home.routeName: (context) => Home(requestApi: RequestApi()),
      },
    ),
  );
}
