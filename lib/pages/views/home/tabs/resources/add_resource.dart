import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:packages_flutter/core/core_export.dart';
import 'package:packages_flutter/pages/widgets/custom_progres_indicator.dart';
import 'package:packages_flutter/pages/views/home/tabs/components/custom_textfield.dart';

class AddResource extends StatefulHookWidget {
  const AddResource({Key? key}) : super(key: key);

  @override
  State<AddResource> createState() => _AddResourceState();
}

class _AddResourceState extends State<AddResource> {
  Color? currentColor;

  @override
  void initState() {
    currentColor = Colors.black;
    super.initState();
  }

  // listen to color change
  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = useTextEditingController();
    TextEditingController yearController = useTextEditingController();
    final resourcesViewModel = context.read<ResourcesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Resource")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            helperText: "Enter name",
            hintText: 'Name',
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: yearController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            maxLength: 4,
            helperText: "Enter year",
            hintText: 'Year',
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: const Color(0xff443a49),
                          onColorChanged: changeColor,
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
            child: Center(
              child: Container(
                height: 58,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: currentColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 5),
                      blurRadius: 3,
                    ),
                  ],
                ),
                // radius: 50,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Pick Color'),
          const SizedBox(height: 50),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // extract name and job text into variables(name, job)
                  String name = nameController.text.trim();
                  int year = int.tryParse(yearController.text.trim()) ?? 0,
                      color = currentColor!.value;

                  if (year < 1000) {
                    context.showErrorSnackBar(message: 'Year must be 4 digits');
                    // DialogUtils.showToast('Year must be 4 digits', 'error');
                    return;
                  }
                  if (name.isEmpty) {
                    context.showErrorSnackBar(
                        message: 'Name field is required');
                    // DialogUtils.showToast('Name field is required', 'error');
                    return;
                  }

                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await resourcesViewModel
                      .addResource(name, year, color)
                      .then((value) {
                    context.showSnackBar(message: '$name added successfully');
                    // DialogUtils.showToast(
                    //     '$name added successfully', 'success');
                    Navigator.pop(context);
                  });
                },
                child:
                    context.watch<ResourcesViewModel>().state == ViewState.busy
                        ? const CustomProgresIndicator()
                        : const Text(
                            'Add Resource',
                            style: TextStyle(fontSize: 15),
                          )),
          ),
        ],
      ),
    );
  }
}
