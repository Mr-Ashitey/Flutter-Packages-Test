import 'package:flutter/material.dart';

class CustomProgresIndicator extends StatelessWidget {
  const CustomProgresIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
      width: 10,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}
