import 'package:flutter/material.dart';
import 'package:packages_flutter/screens/color_picker.dart';
import 'package:packages_flutter/screens/date_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DatePicker(),
                    )),
                child: const Text('Date Picker')),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ColorPicker(),
                    )),
                child: const Text('Color Picker')),
          ],
        ),
      ),
    );
  }
}
