// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:packages_flutter/core/utils/dialog.dart';
import 'package:packages_flutter/helpers/constants/route_names.dart';
import 'package:packages_flutter/pages/widgets/custom_progres_indicator.dart';
import 'package:packages_flutter/pages/widgets/motivational_quote.dart';
import 'package:provider/provider.dart';

import '../../../core/viewModels/auth_provider/auth_view_model.dart';
import '../../../core/viewModels/shared_viewModel.dart';

class Register extends HookWidget {
  const Register({Key? key}) : super(key: key);

  static String routeName = RouteNames.registerRoute;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();

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
                  DialogUtils.showToast('All fields are required', 'error');
                  return;
                }

                try {
                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await authViewModel.register(email, password);

                  // show success alert/snackbar and navigate to login screen to allow user to log into the app
                  DialogUtils.showToast(
                      'Registration successful: Login to continue', 'success');
                  Navigator.of(context)
                      .pushReplacementNamed(RouteNames.loginRoute);
                } catch (error) {
                  emailController.clear();
                  passwordController.clear();
                  DialogUtils.showToast(error.toString(), 'error');
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: authViewModel.state == ViewState.busy
                  ? const CustomProgresIndicator()
                  : const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
            TextButton(
              onPressed: () {
                authViewModel.state == ViewState.busy
                    ? null
                    : Navigator.pushReplacementNamed(
                        context, RouteNames.loginRoute);
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
