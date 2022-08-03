// Routes
import 'package:flutter/material.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
const String homeRoute = '/home';

// scaffold messager alerts
void showSnackBar(BuildContext context, String message, String type) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(
      backgroundColor: type == 'error' ? Colors.red : Colors.green,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
}

// value setters
void setLoading(ValueNotifier<bool> isLoading, bool value) {
  isLoading.value = value;
}
