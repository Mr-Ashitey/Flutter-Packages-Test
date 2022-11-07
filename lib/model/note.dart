// name of our table
const String tableNotes = 'notes';

// our field (column) names
class NoteFields {
  static const List<String> columns = [
    // Add all fields
    id, isImportant, number, title, description, time
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final DateTime? createdTime;

  const Note(
      {this.id,
      this.isImportant,
      this.number,
      this.title,
      this.description,
      this.createdTime});

  // return a copy of our note table column
  Note copy({
    int? id,
    final bool? isImportant,
    final int? number,
    final String? title,
    final String? description,
    final DateTime? createdTime,
  }) =>
      Note(
          id: id ?? this.id,
          isImportant: isImportant ?? this.isImportant,
          number: number ?? this.number,
          title: title ?? this.title,
          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime);

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        isImportant: json[NoteFields.isImportant] == 1,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.number: number,
        NoteFields.isImportant: isImportant! ? 1 : 0,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime!.toIso8601String(),
      };
}
