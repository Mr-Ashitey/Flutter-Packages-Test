import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String helperText;
  final String hintText;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.textInputAction,
      required this.helperText,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        cursorColor: Colors.black,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          helperText: helperText,
        ),
      ),
    );
  }
}
