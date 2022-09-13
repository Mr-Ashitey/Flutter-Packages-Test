import 'package:flutter/material.dart';
import 'package:packages_flutter/core/viewModels/users_provider/users_view_model.dart';
import 'package:packages_flutter/helpers/constants.dart';
import 'package:packages_flutter/pages/views/home/tabs/components/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../core/viewModels/shared_viewModel.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController? nameController;
  TextEditingController? jobController;

  @override
  void initState() {
    nameController = TextEditingController();
    jobController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    jobController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersViewModel = context.read<UsersViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
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
            controller: jobController!,
            textInputAction: TextInputAction.done,
            helperText: "Enter job",
            hintText: 'Job',
          ),
          const SizedBox(height: 50),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  // extract name and job text into variables(name, job)
                  String name = nameController!.text.trim(),
                      job = jobController!.text.trim();

                  if (name.isEmpty || job.isEmpty) {
                    showToast('All fields are required', 'error');
                    return;
                  }

                  FocusManager.instance.primaryFocus!
                      .unfocus(); // unfocus keyboard
                  await usersViewModel
                      .addUser(name, job)
                      .then((value) => Navigator.pop(context))
                      .catchError(
                          (error) => showToast(error.toString(), 'error'));
                },
                child: context.watch<UsersViewModel>().state == ViewState.busy
                    ? const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
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
