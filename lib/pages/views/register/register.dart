import 'package:flutter/material.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/pages/widgets/motivational_quote.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  static String routeName = registerRoute;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    ValueNotifier<bool> isLoading = ValueNotifier(false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const MotivationalQuote(),
            const Spacer(),
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [],
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, loginRoute);
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text(
                "Login!",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
