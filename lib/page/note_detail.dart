import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/notes_db.dart';
import '../model/note.dart';
import 'add_edit_note.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
  const NoteDetailPage({Key? key, required this.noteId}) : super(key: key);

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  // @override
  // void dispose() {
  //   NoteDatabase.instance.close();
  //   super.dispose();
  // }

  Future<void> refreshNote() async {
    setState(() => isLoading = true);

    note = await NoteDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime!),
                      style: const TextStyle(color: Colors.white38),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      note.description!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ));
  }

  Widget editButton() {
    return IconButton(
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddEditNote(note: note)));
        },
        icon: const Icon(
          Icons.edit,
          // color: Colors.red,
        ));
  }

  Widget deleteButton() {
    return IconButton(
        onPressed: () async {
          await NoteDatabase.instance.deleteNote(widget.noteId);

          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ));
  }
}
