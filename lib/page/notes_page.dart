import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:packages_flutter/database/notes_db.dart';

import '../model/note.dart';
import 'add_edit_note.dart';
import 'note_detail.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();
    super.dispose();
  }

  Future<void> refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NoteDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 24),
        ),
        actions: const [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : notes.isEmpty
                  ? const Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white),
                    )
                  : buildNotes()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddEditNote()));

          refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildNotes() {
    return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: notes
            .map(
              (note) => StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                // mainAxisCellCount: 2,
                child: Card(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NoteDetailPage(noteId: note.id!)));
                    },
                    child: Column(
                      children: [
                        Text(note.number.toString()),
                        Text(note.title!),
                        Text(note.description!),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList()
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 2,
        //   mainAxisCellCount: 2,
        //   child: Tile(index: 0),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 2,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 1),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 1,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 2),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 1,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 3),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 4,
        //   mainAxisCellCount: 2,
        //   child: Tile(index: 4),
        // ),

        );
  }
}
