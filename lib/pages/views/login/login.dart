// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:packages_flutter/helpers/constants.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/viewModels/shared_viewModel.dart';
import '../../widgets/motivational_quote.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static String routeName = loginRoute;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

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
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              key: const Key('email'),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const Key('password'),
              obscureText: true,
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white30,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // extract email and password text into variables(email, password)
                String email = emailController.text.trim(),
                    password = passwordController.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  showToast('All fields are required', 'error');
                  return;
                }

                try {
                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await authViewModel.login(email, password);

                  // navigate to home page
                  Navigator.pushNamedAndRemoveUntil(
                      context, homeRoute, (route) => false);
                } catch (error) {
                  showToast(error.toString(), 'error');
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: authViewModel.state == ViewState.busy
                  ? const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
            TextButton(
              onPressed: () {
                authViewModel.state == ViewState.busy
                    ? null
                    : Navigator.pushReplacementNamed(context, registerRoute);
              },
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text(
                "Register!",
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
