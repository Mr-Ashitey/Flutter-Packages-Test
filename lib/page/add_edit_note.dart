import 'package:flutter/material.dart';
import 'package:packages_flutter/database/notes_db.dart';

import '../model/note.dart';

class AddEditNote extends StatefulWidget {
  final Note? note;
  const AddEditNote({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  bool? isImportant;
  int? number;
  String? title;
  String? description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleController.text = widget.note!.title!;
      descriptionController.text = widget.note!.description!;
      numberController.text = widget.note!.number!.toString();
    }
    super.initState();
  }

  void addOrUpdateNote() async {
    final isValid = number != null && title != null && description != null;
    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.pop(context);
    } else {
      print("Form invalid");
    }
  }

  Future<void> updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NoteDatabase.instance.updateNote(note);
  }

  Future<void> addNote() async {
    final note = Note(
      title: title,
      description: description,
      number: number,
      isImportant: true,
      createdTime: DateTime.now(),
    );

    await NoteDatabase.instance.create(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'title',
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onChanged: (value) {
                title = titleController.text;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'description',
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onChanged: (value) {
                description = descriptionController.text;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'number',
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onChanged: (value) {
                number = int.parse(numberController.text);
              },
            ),
            ElevatedButton(
              onPressed: addOrUpdateNote,
              child: Text(widget.note != null ? 'Edit' : 'Add'),
            ),
          ],
        ),
      ),
    );
  }
}
