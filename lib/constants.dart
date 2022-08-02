// Routes
import 'package:flutter/material.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';

// scaffold messager alerts
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
}

// value setters
void setLoading(ValueNotifier<bool> isLoading, bool value) {
  isLoading.value = value;
}
