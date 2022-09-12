import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText('Name'),
          buildTextField(nameController!, "Enter name"),
          labelText('Job'),
          buildTextField(jobController!, "Enter job"),
          ElevatedButton(onPressed: () {}, child: const Text('Add User')),
        ],
      ),
    );
  }

  Text labelText(String label) => Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  TextField buildTextField(
      TextEditingController controller, String helperText) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
        ),
        helperText: helperText,
      ),
    );
  }
}
