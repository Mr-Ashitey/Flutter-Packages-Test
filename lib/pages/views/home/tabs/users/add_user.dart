import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:packages_flutter/core/utils/dialog.dart';
import 'package:packages_flutter/core/viewModels/users_provider/users_view_model.dart';
import 'package:packages_flutter/pages/widgets/custom_progres_indicator.dart';
import 'package:packages_flutter/pages/views/home/tabs/components/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../core/viewModels/shared_viewModel.dart';

class AddUser extends HookWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = useTextEditingController();
    TextEditingController jobController = useTextEditingController();
    final usersViewModel = context.read<UsersViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            helperText: "Enter name",
            hintText: 'Name',
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: jobController,
            textInputAction: TextInputAction.done,
            helperText: "Enter job",
            hintText: 'Job',
          ),
          const SizedBox(height: 50),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // extract name and job text into variables(name, job)
                  String name = nameController.text.trim(),
                      job = jobController.text.trim();

                  if (name.isEmpty || job.isEmpty) {
                    context.showErrorSnackBar(
                        message: 'All fields are required');
                    // DialogUtils.showToast('All fields are required', 'error');
                    return;
                  }

                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await usersViewModel.addUser(name, job).then((value) {
                    context.showSnackBar(message: '$name added successfully');
                    // DialogUtils.showToast(
                    //     '$name added successfully', 'success');
                    Navigator.pop(context);
                  });
                },
                child: context.watch<UsersViewModel>().state == ViewState.busy
                    ? const CustomProgresIndicator()
                    : const Text(
                        'Add User',
                        style: TextStyle(fontSize: 15),
                      )),
          ),
        ],
      ),
    );
  }
}
