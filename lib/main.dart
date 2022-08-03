import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 15),
        invalidateSessionForUserInactiviity: const Duration(seconds: 15));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        _navigator
            .pushReplacement(MaterialPageRoute(builder: (_) => const Login()));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        _navigator
            .pushReplacement(MaterialPageRoute(builder: (_) => const Login()));
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: _navigatorKey,
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
      ),
    );
  }
}
