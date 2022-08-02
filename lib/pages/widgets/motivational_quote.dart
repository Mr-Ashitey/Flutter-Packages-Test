import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MotivationalQuote extends StatelessWidget {
  const MotivationalQuote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.homemadeApple(
        fontSize: 20,
        color: Colors.black,
      ),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          TyperAnimatedText('It is not enough to do your best,'),
          TyperAnimatedText('you must know what to do,'),
          TyperAnimatedText('and then do your best'),
          TyperAnimatedText('- W.Edwards Deming'),
        ],
      ),
    );
  }
}
