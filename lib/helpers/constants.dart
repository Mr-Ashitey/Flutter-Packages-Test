// Routes
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String homeRoute = '/';
const String loginRoute = '/login';
const String registerRoute = '/register';
const String addUserRoute = '/add-user';

// messager alerts
void showToast(String message, String type) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: type == 'error' ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
// void showSnackBar(BuildContext context, String message, String type) {
//   ScaffoldMessenger.of(context)
//     ..clearSnackBars()
//     ..showSnackBar(SnackBar(
//       backgroundColor: type == 'error' ? Colors.red : Colors.green,
//       content: Text(message),
//       behavior: SnackBarBehavior.floating,
//     ));
// }
