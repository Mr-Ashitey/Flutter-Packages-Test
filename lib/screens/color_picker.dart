import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  List<Color>? currentColor = List<Color>.filled(3, Colors.black);
  @override
  Widget build(BuildContext context) {
    buildColor(int index, Color color) {
      return GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: const Color.fromARGB(255, 254, 253, 255),
                      onColorChanged: (color) {
                        setState(() => currentColor![index] = color);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              });
        },
        child: SizedBox(
          width: 100,
          height: 100,
          child: Card(
            color: color,
            shadowColor: currentColor![index],
            elevation: 5,
            shape: const CircleBorder(),
            // foregroundColor: Colors.green,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Color Picker')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildColor(0, currentColor![0]),
              buildColor(1, currentColor![1]),
              buildColor(2, currentColor![2]),
            ],
          ),
        ),
      ),
    );
  }
}
