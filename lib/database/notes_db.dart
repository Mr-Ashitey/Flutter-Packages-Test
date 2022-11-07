import 'package:packages_flutter/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  // check if database instance exists and create else return it
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // create database tables here
  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String boolType = 'BOOLEAN NOT NULL';
    const String integerType = 'INTEGER NOT NULL';
    const String textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes(
      ${NoteFields.id} $idType
      ${NoteFields.isImportant} $boolType
      ${NoteFields.number} $integerType
      ${NoteFields.time} $textType
      ${NoteFields.description} $textType
      ${NoteFields.time} $textType
    )
    ''');
    return;
  }

  // creating/inserting a column/data into the note table
  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());

    return note.copy(id: id);
  }

  // read a single column in note table
  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final result = await db.query(tableNotes,
        columns: NoteFields.columns,
        where: '${NoteFields.id} = ?',
        whereArgs: [id]);

    if (result.isNotEmpty) {
      print(result);
      return Note.fromJson(result.first);
    }

    throw Exception('ID not found');
  }

  // read all columns in note table
  Future<List<Note>> readAllNote() async {
    final db = await instance.database;
    const String orderBy = '${NoteFields.time} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    if (result.isNotEmpty) {
      return result.map((json) => Note.fromJson(json)).toList();
    }

    throw Exception('Empty items');
  }

  // update a note in the note table
  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    final result = await db.update(tableNotes, note.toJson(),
        where: '${NoteFields.id} = ?', whereArgs: [note.id]);

    print(result);
    return result;
    // if (result) {}
  }

  // delete a note in the note table
  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    final result = await db
        .delete(tableNotes, where: '${NoteFields.id} = ?', whereArgs: [id]);
    print(result);
    return result;
  }

  // close database instance
  Future<void> close() async {
    final db = await instance.database;

    db.close();
  }
}
