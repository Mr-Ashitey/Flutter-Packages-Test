import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:packages_flutter/core/viewModels/resources_view_model.dart';
import 'package:packages_flutter/pages/views/home/tabs/components/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../core/viewModels/shared_viewModel.dart';
import '../../../../../helpers/constants.dart';

class AddResource extends StatefulWidget {
  const AddResource({Key? key}) : super(key: key);

  @override
  State<AddResource> createState() => _AddResourceState();
}

class _AddResourceState extends State<AddResource> {
  TextEditingController? nameController;
  TextEditingController? yearController;
  TextEditingController? pantoneController;
  Color? currentColor;

  @override
  void initState() {
    nameController = TextEditingController();
    yearController = TextEditingController();
    pantoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    yearController!.dispose();
    pantoneController!.dispose();
    super.dispose();
  }

  // listen to color change
  void changeColor(Color color) => setState(() => currentColor = color);

  @override
  Widget build(BuildContext context) {
    final resourcesViewModel = context.read<ResourcesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Resource")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: nameController!,
            textInputAction: TextInputAction.next,
            helperText: "Enter name",
            hintText: 'Name',
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: yearController!,
            textInputAction: TextInputAction.done,
            helperText: "Enter year",
            hintText: 'Year',
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: pantoneController!,
            textInputAction: TextInputAction.done,
            helperText: "Enter pantone value",
            hintText: 'Pantone Value',
          ),
          const SizedBox(height: 50),
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
            child: CircleAvatar(backgroundColor: currentColor),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // extract name and job text into variables(name, job)
                  String name = nameController!.text.trim(),
                      year = yearController!.text.trim(),
                      pantone = pantoneController!.text.trim();

                  if (name.isEmpty ||
                      // color.toString().isEmpty ||
                      year.isEmpty ||
                      pantone.isEmpty) {
                    showToast('All fields are required', 'error');
                    return;
                  }

                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await resourcesViewModel
                      .addResource(name, 'color', year, pantone)
                      .then((value) => Navigator.pop(context))
                      .catchError(
                          (error) => showToast(error.toString(), 'error'));
                },
                child:
                    context.watch<ResourcesViewModel>().state == ViewState.busy
                        ? const SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
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
