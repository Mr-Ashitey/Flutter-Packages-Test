// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/pages/widgets/motivational_quote.dart';

import '../../../core/viewModels/auth_view_model.dart';

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
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, bool value, child) {
                return ElevatedButton(
                  onPressed: () async {
                    // extract email and password text into variables(email, password)
                    String email = emailController.text,
                        password = passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      showSnackBar(context, 'All fields are required', 'error');
                      return;
                    }

                    try {
                      setLoading(isLoading, true);
                      FocusManager.instance.primaryFocus!
                          .unfocus(); // unfocus keyboard
                      await AuthViewModel().register(email, password);

                      setLoading(isLoading, false);

                      // show success alert/snackbar and navigate to login screen to allow user to log into the app
                      showSnackBar(
                          context,
                          'Registration successful: Login to continue',
                          'success');
                      Navigator.of(context).pushReplacementNamed(loginRoute);
                    } catch (error) {
                      setLoading(isLoading, false);
                      showSnackBar(context, error.toString(), 'error');
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: value == true
                      ? const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Text(
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
