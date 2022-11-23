import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.green,
  }) {
    ScaffoldMessenger.of(this)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

class DialogUtils {
  // messager alerts
  static void showToast(String message, String type) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.SNACKBAR,
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

}
