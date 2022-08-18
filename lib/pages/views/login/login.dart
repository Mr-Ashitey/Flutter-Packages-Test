// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:packages_flutter/constants.dart';
import 'package:packages_flutter/core/services/api_request.dart';
import 'package:packages_flutter/core/viewModels/auth_view_model.dart';

import '../../widgets/motivational_quote.dart';

class Login extends HookWidget {
  final RequestApi? requestApi;
  const Login({Key? key, required this.requestApi}) : super(key: key);

  static const routeName = loginRoute;

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final ValueNotifier<bool> isLoading = useValueNotifier(false);

    final AuthViewModel authViewModel = AuthViewModel(requestApi!);
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
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, value, __) {
                  return ElevatedButton(
                    onPressed: () async {
                      // extract email and password text into variables(email, password)
                      String email = emailController.text.trim(),
                          password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        showSnackBar(
                            context, 'All fields are required', 'error');
                        return;
                      }

                      try {
                        setLoading(isLoading, true);
                        FocusManager.instance.primaryFocus!
                            .unfocus(); // unfocus keyboard
                        await authViewModel.login(email, password);

                        setLoading(isLoading, false);

                        // navigate to home page
                        Navigator.pushReplacementNamed(context, homeRoute);
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
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                  );
                }),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, registerRoute);
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
