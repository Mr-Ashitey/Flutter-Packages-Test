import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packages_flutter/pages/views/home/home.dart';
import 'package:packages_flutter/pages/views/login/login.dart';
import 'package:packages_flutter/pages/views/register/register.dart';
import 'package:provider/provider.dart';

import 'core/viewModels/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.senTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      routes: {
        Login.routeName: (context) => const Login(),
        Register.routeName: (context) => const Register(),
        Home.routeName: (context) => const Home(),
      },
    );
  }
}
