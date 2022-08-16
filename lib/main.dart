import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Text('Hello World'),
        ),
      ),
    ),
  );
}
